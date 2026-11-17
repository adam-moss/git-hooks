#!/bin/sh
set -eu

ROOT=$(CDPATH='' cd "$(dirname "$0")/.." && pwd)
GIT_HOOKS=$ROOT/bin/git-hooks
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' 0 HUP INT TERM

fail() {
  printf 'not ok - %s\n' "$*" >&2
  exit 1
}

pass() {
  printf 'ok - %s\n' "$*"
}

git -C "$TMP" init -q
git -C "$TMP" config user.name "Git Hooks Test"
git -C "$TMP" config user.email "git-hooks@example.invalid"
printf 'steps {}\n' >"$TMP/hk.pkl"
printf 'feat: test\n' >"$TMP/message"

(
  cd "$TMP"
  "$GIT_HOOKS" trailers add-config-trailer message
  grep -q '^Git-Hooks-Config: hk.pkl@sha256:' message || fail "config trailer missing"
  "$GIT_HOOKS" trailers add-config-trailer message
  [ "$(grep -c '^Git-Hooks-Config:' message)" -eq 1 ] || fail "config trailer is not idempotent"
)
pass "configuration digest trailer"

(
  cd "$TMP"
  printf 'feat: test skipped\n' >message
  HK_SKIP_STEPS='markdown,shellcheck' "$GIT_HOOKS" trailers add-skipped-trailer message
  grep -q '^Skipped-Checks: markdown, shellcheck$' message || fail "skipped checks trailer missing"
)
pass "skipped checks trailer"

(
  cd "$TMP"
  printf 'feat: no skips\n' >message
  "$GIT_HOOKS" trailers add-skipped-trailer message
  ! grep -q '^Skipped-Checks:' message || fail "unexpected skipped checks trailer"
)
pass "no trailer when no steps were skipped"

if printf '' | GIT_PUSH_OPTION_0=ci.skip "$GIT_HOOKS" community-health block-push-skip-ci >/dev/null 2>&1; then
  fail "ci.skip push option was not rejected"
fi
pass "CI-skip push option rejected"

(
  cd "$TMP"
  printf 'file\n' >tracked.txt
  git add tracked.txt
  git commit -q -m 'feat: test [skip ci]'
  commit=$(git rev-parse HEAD)
  push_update="refs/heads/topic $commit refs/heads/topic 0000000000000000000000000000000000000000"
  if HK_HOOK_STDIN="$push_update" "$GIT_HOOKS" community-health block-push-skip-ci </dev/null >/dev/null 2>&1; then
    fail "skip-ci commit message was not rejected"
  fi
)
pass "CI-skip commit marker rejected"

printf 'All smoke tests passed.\n'
