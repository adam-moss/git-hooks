# Migration notes

This repository consolidates three pre-commit hook projects into a single
framework-independent POSIX shell command.

## Source projects

- [pre-commit-trailer](https://gitlab.com/adam-moss/pre-commit-trailer)
- [pre-commit-ssh-git-signing-key](https://gitlab.com/adam-moss/pre-commit-ssh-git-signing-key)
- [pre-commit-community-health](https://gitlab.com/repo-hooks/pre-commit-community-health)

## Behaviour mapping

| Former hook | New command or disposition |
| --- | --- |
| `add-pre-commit-config-trailer` | `trailers add-config-trailer`; records the active hk configuration digest, with legacy pre-commit config fallback. |
| `add-pre-commit-user-skipped-trailer` | `trailers add-skipped-trailer`; reads hk's `HK_SKIP_STEPS` / `HK_SKIP_STEP`. |
| `add-ssh-git-signing-key` | `signing add-ssh-key`. |
| `remove-ssh-git-signing-key` | `signing remove-ssh-key`. |
| `block-push-skip-ci` | `community-health block-push-skip-ci`; checks push options and commit messages. |
| `block-commit-no-verify` | Not implemented as a local hook; see below. |

## Why block-commit-no-verify is not a local hook

Git's `--no-verify` option prevents Git from invoking the `pre-commit` and
`commit-msg` hooks. A hook that Git does not invoke cannot reliably detect
that the option was supplied. This is a property of Git's hook lifecycle, not a
limitation of a shell implementation.

Do not claim that a client-side script can prevent this bypass. Run mandatory
checks in CI and require successful checks through branch protection or rulesets.
A `prepare-commit-msg` hook is not bypassed by `--no-verify`, but Git does not
pass the original command-line arguments to it, so it cannot reliably identify
the flag either.

## Compatibility and review status

The SSH signing-key project's published README documents adding
`user.signingKey` to `ssh-agent`, using no timeout and enabling macOS
Keychain support where applicable. The implementation follows that documented
contract.

The source repositories for the trailer and community-health hooks should be
reviewed alongside this migration before declaring exact behavioural
compatibility. The new commands intentionally use hk terminology and
framework-neutral trailer names; they are not byte-for-byte ports of the old
scripts.
