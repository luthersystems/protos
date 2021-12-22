load("@io_bazel_rules_go//go:def.bzl", "GoSource")

# adapted from
# https://www.grahambrooks.com/software-development/2021/08/30/user-defined-bazel-arguments.html
def _update_generated_code_impl(ctx):
    shell_commands = ""
    for t in ctx.attr.srcs:
        for s in t[GoSource].srcs:
            shell_commands += "set -euo pipefail\n"
            shell_commands += 'cd "$BUILD_WORKING_DIRECTORY"\n'
            shell_commands += 'dst="%s/$(basename %s)"\n' % (t.label.package, s.path)
            shell_commands += 'cp -v "%s" "$dst"\n' % (s.path)
            shell_commands += 'chmod -v 0644 "$dst"\n'

    ctx.actions.write(
        output = ctx.outputs.executable,
        is_executable = True,
        content = shell_commands,
    )
    runfiles = ctx.runfiles(files = ctx.files.srcs)
    return DefaultInfo(
        executable = ctx.outputs.executable,
        runfiles = runfiles,
    )

update_generated_code = rule(
    executable = True,
    implementation = _update_generated_code_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
    },
)
