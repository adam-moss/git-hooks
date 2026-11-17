# Git Hooks

A small collection of POSIX shell utilities for Git workflows and repository
contribution health.

The tools are intentionally independent of a particular hook manager. They can
be invoked directly, from Git hooks, or through hk.

## Design goals

- **Portable:** POSIX shell with common Git and OpenSSH utilities.
- **Composable:** one command with subcommands for related operations.
- **Auditable:** small scripts, explicit inputs and predictable exit codes.
- **Framework-independent:** no runtime dependency on pre-commit or prek.
- **Defence in depth:** local checks are backed by CI and repository policy.

## Current commands

| Command | Purpose |
| --- | --- |
| `trailers add-config-trailer` | Record the digest of the active hook configuration in a commit message. |
| `trailers add-skipped-trailer` | Record hk steps explicitly skipped for a commit. |
| `signing add-ssh-key` | Add the configured SSH signing key to ssh-agent. |
| `signing remove-ssh-key` | Remove the configured SSH signing key from ssh-agent. |
| `community-health block-push-skip-ci` | Reject push options or commits that request skipping CI. |

Run the ShellSpec unit and integration suite with `mise run test`. It uses
temporary Git repositories and stub executables, so it does not require a real
SSH agent or network access.

See [installation](installation.md), [commands](commands.md) and
[migration notes](migration.md).
