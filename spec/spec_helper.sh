#!/bin/sh
# Shared setup for ShellSpec.
ROOT=$(git rev-parse --show-toplevel)
# shellcheck disable=SC2034
GIT_HOOKS=$ROOT/bin/git-hooks
PROGRAM=git-hooks
. "$ROOT/lib/git-hooks.sh"

setup_repo() {
  TMP=$(mktemp -d "${TMPDIR:-/tmp}/git-hooks-spec.XXXXXX")
  git -C "$TMP" init -q
  git -C "$TMP" config user.name "Git Hooks Test"
  git -C "$TMP" config user.email "git-hooks@example.invalid"
  printf 'steps {}\n' >"$TMP/hk.pkl"
  printf 'feat: test\n' >"$TMP/message"
}

cleanup_repo() {
  [ -z "${TMP:-}" ] || rm -rf "$TMP"
}
