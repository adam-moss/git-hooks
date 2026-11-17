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

See the [documentation](docs/index.md) for installation,
configuration, migration notes and contribution guidance.

## Development

```sh
mise install
hk install --mise
mise run ci
```

The project uses POSIX shell, ShellCheck, shfmt, rumdl, lychee, actionlint,
zizmor, Zensical, mise and hk.

## Security

These commands run with the privileges of the current user. Review scripts
before installing them into repositories you do not trust. Client-side Git
hooks are convenience controls, not security boundaries; enforce mandatory
policy in CI and repository rules.

See [SECURITY.md](SECURITY.md) for reporting vulnerabilities.
