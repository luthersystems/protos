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
#     drops every require (#44, #45, #46; fixed by hand in #48).
# This script fails on both, so a Dependabot PR that breaks either is red.
#
# Usage (from the repository root): scripts/connectorhub-check.sh
# Needs buf and a Go toolchain that can run the go line of connectorhub/go.mod.

set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$root/connectorhub"
fails=0

# buf build compiles every connector proto against the deps pinned in
# buf.lock, so a lock that lacks an imported file fails here.
if buf build; then
  echo "ok   buf build connectorhub"
else
  echo "FAIL buf build connectorhub: run 'buf dep update' in connectorhub/ and commit buf.lock"
  fails=$((fails + 1))
fi

# go mod tidy -diff prints the change tidy would make and exits 1 if there
# is one. A clean result means a Dependabot bump (which runs tidy) keeps the
# requires that local buf generation needs.
if go mod tidy -diff; then
  echo "ok   go mod tidy keeps connectorhub/go.mod"
else
  echo "FAIL go mod tidy would change connectorhub/go.mod (see the diff above)"
  fails=$((fails + 1))
fi

if [ "$fails" -ne 0 ]; then
  echo "$fails check(s) failed"
  exit 1
fi
