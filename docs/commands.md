# Commands

Run `git-hooks --help` for the command summary.

## Commit trailers

### Add the configuration digest

```sh
git-hooks trailers add-config-trailer .git/COMMIT_EDITMSG
```

The command finds the active configuration in this order:

1. `GIT_HOOKS_CONFIG`, if set.
2. `hk.pkl`.
3. `.config/hk.pkl`.
4. `hk.local.pkl`.
5. `.config/hk.local.pkl`.
6. `.pre-commit-config.yaml` for legacy repositories.

It calculates a SHA-256 digest and uses `git interpret-trailers` to add or
replace the `Git-Hooks-Config` trailer. The trailer records both the path and
digest. Existing matching trailers are replaced, making the operation
idempotent.

### Record skipped checks

```sh
HK_SKIP_STEPS=markdown,shellcheck git-hooks trailers add-skipped-trailer .git/COMMIT_EDITMSG
```

The command reads `HK_SKIP_STEPS` (or `HK_SKIP_STEP`) and falls back to
`git config hk.skipSteps`. It writes a `Skipped-Checks` trailer only when
one or more steps were explicitly skipped. Checks that did not apply to the
changed files are not recorded.

Step names are restricted to a conservative character set before being written
to commit metadata.

## SSH signing key

The signing commands require `gpg.format=ssh` and read `user.signingKey` from Git configuration:

```sh
git-hooks signing add-ssh-key
git-hooks signing remove-ssh-key
```

The add command verifies that the configured value names a readable private
key file and passes it to `ssh-add` with no expiry. On macOS it also requests
Keychain integration. The remove command asks `ssh-add` to remove that key.

The private key is never read by the script. Do not set `user.signingKey` to a
public key, an inline key expression, or an untrusted path. The key is added
without an expiry and removed by hk's `post-commit` hook; if a commit is
aborted after `prepare-commit-msg`, remove it manually with `ssh-add -d`.

## Block pushes that skip CI

The repository's `hk.pkl` wires this command into Git's `pre-push` event.
Install the configured hooks with:

```sh
hk install --mise
```

hk passes its `hook_stdin` template value to the command's standard input.
The command checks Git push options for `ci.skip` and `ci.no_pipeline`, and
checks commits in the pushed ranges for GitHub/GitLab skip markers such as
`[skip ci]`, `[ci skip]`, `[no ci]` and `[skip actions]`.

This is a local guard only. Git hooks can be bypassed and do not replace
server-side enforcement.
