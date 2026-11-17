# Git Hooks

POSIX shell utilities for Git workflows and repository contribution health.

The project consolidates a small collection of formerly separate pre-commit hook
repositories into one framework-independent command-line tool. It is designed to
work with Git directly and can be orchestrated by [hk](https://hk.jdx.dev/) and
installed or versioned with [mise](https://mise.jdx.dev/).

> [!WARNING]
> This is an initial migration. The SSH signing-key behaviour is based on the
> original project's published documentation. The trailer and community-health
> implementations need review against their original source repositories before
> this migration should be treated as behaviourally identical.

## Commands

```sh
git-hooks trailers add-config-trailer <commit-message-file>
git-hooks trailers add-skipped-trailer <commit-message-file>
git-hooks signing add-ssh-key
git-hooks signing remove-ssh-key
git-hooks community-health block-push-skip-ci
```

See the [documentation](https://adam-moss.github.io/git-hooks/latest/) for
installation, configuration, migration notes and contribution guidance. Published
documentation is versioned: the development build follows `main`, and release
tags publish immutable version paths plus the `latest` alias.

## Development

```sh
mise install
hk install --mise
mise run ci
```

The project uses POSIX shell, ShellSpec, ShellCheck, shfmt, Betterleaks, rumdl,
lychee, actionlint, zizmor, Zensical, mise and hk.

Run ShellSpec under compatible shells with `mise run test --shell bash`,
`mise run test --shell zsh`, or `mise run test --shell sh`. Fish is covered by
a separate CLI compatibility smoke test; it is not a ShellSpec execution shell.
The `mise run git-hooks` task exposes the CLI's subcommands with generated
usage and completion support; direct `git-hooks` invocation remains available
to Git and hk.

Betterleaks scans staged changes in the pre-commit hook and scans repository
history in CI. Scanner output is redacted; do not paste secret material into
issues or logs.

## Security

These commands run with the privileges of the current user. Review scripts
before installing them into repositories you do not trust. Client-side Git
hooks are convenience controls, not security boundaries; enforce mandatory
policy in CI and repository rules.

See [SECURITY.md](SECURITY.md) for reporting vulnerabilities.
