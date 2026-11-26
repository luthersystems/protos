#!/usr/bin/env bash
# Check that the connectorhub module still builds after a dependency change.
#
# Why this exists (#49): connectorhub/ is excluded from the root buf module
# (buf.yaml), so the root buf lint in CI never compiles its protos, and its
# Go module has no Go files of its own (the generated *.pb.go files are
# gitignored). Two breaks got through because nothing checked either:
#   - connectorhub/buf.lock pinned a buf.build/luthersystems/protos commit
#     older than annotations/v1/sensitive.proto, so `buf build` failed with
#     "imported file does not exist" on 73 connector protos.
#   - Dependabot runs `go mod tidy`, and tidy on a module with no Go files
#     drops every require (#44, #45, #46; fixed by hand in #48). deps.go now
#     gives tidy the imports to keep.
# The checks below fail on both, and on the ways each can come back: a
# deps.go that misses a package the generated code needs, and a Dependabot
# bump of the protos Go SDK that leaves buf.lock on another commit.
#
# Usage (from the repository root): scripts/connectorhub-check.sh
# Needs buf (with access to buf.build for the remote plugins) and a Go
# toolchain that can run the go line of connectorhub/go.mod.

set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$root/connectorhub"
fails=0

fail() {
  echo "FAIL $*"
  fails=$((fails + 1))
}

# 1. buf build compiles every connector proto against the deps pinned in
# buf.lock, so a lock that lacks an imported file fails here.
if buf build; then
  echo "ok   buf build connectorhub"
else
  fail "buf build connectorhub (see the output above; for 'imported file does not exist', run 'buf dep update' in connectorhub/ and commit buf.lock)"
fi

# 2. buf.lock and go.mod must name the same luthersystems/protos commit.
# Dependabot bumps the Go SDK in go.mod and never touches buf.lock, so
# without this check the protos would build against one commit while the
# Go code uses another. The go.mod pseudo-version ends in the first 12
# characters of the BSR commit (v1.36.12-<time>-<commit12>.<n>).
lock_commit=$(awk '/name: buf.build\/luthersystems\/protos$/{getline; print $2; exit}' buf.lock)
mod_commit=$(awk '$1 == "buf.build/gen/go/luthersystems/protos/protocolbuffers/go" {print $2; exit}' go.mod |
  sed -E 's/^v[^-]+-[0-9]{14}-([0-9a-f]{12}).*/\1/')
if [ -n "$lock_commit" ] && [ -n "$mod_commit" ] && [ "${lock_commit:0:12}" = "$mod_commit" ]; then
  echo "ok   buf.lock and go.mod pin protos commit $mod_commit"
else
  fail "buf.lock pins protos commit '${lock_commit:-none}', go.mod pins '${mod_commit:-none}'; run 'buf dep update' in connectorhub/ or bump go.mod so they match"
fi

# 3. go mod tidy -diff on the module as committed, which is what Dependabot
# sees: tidy must keep every require.
if go mod tidy -diff; then
  echo "ok   go mod tidy keeps connectorhub/go.mod and go.sum"
else
  fail "go mod tidy -diff in connectorhub (see the output above: a diff, or a download error)"
fi

# 4. The same checks with the generated code in place. deps.go lists the
# imports of the generated code by hand; this step finds a list that is out
# of date. If the generated code needs a module go.mod does not require,
# go build or tidy -diff fails here, while step 3 cannot see it.
gen=$(mktemp -d)
trap 'rm -rf "$gen"' EXIT
cp -R . "$gen"
if (cd "$gen" && buf generate && go build ./... && go mod tidy -diff); then
  echo "ok   generated Go code builds, and tidy keeps go.mod with it"
else
  fail "generated connectorhub Go code (see the output above; a missing require means deps.go needs the new import)"
fi

if [ "$fails" -ne 0 ]; then
  echo "$fails check(s) failed"
  exit 1
fi
