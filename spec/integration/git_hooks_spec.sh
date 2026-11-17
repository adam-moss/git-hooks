Describe 'git-hooks command integration'
  BeforeEach 'setup_repo'
  AfterEach 'cleanup_repo'

  It 'adds and replaces the configuration digest trailer idempotently'
    When run command sh -c '
      cd "$1" || exit 1
      "$2" trailers add-config-trailer message || exit
      "$2" trailers add-config-trailer message || exit
      grep -c "^Git-Hooks-Config: hk.pkl@sha256:" message
    ' sh "$TMP" "$GIT_HOOKS"
    The output should eq '1'
    The status should be success
  End

  It 'records explicitly skipped hk steps'
    When run command env HK_SKIP_STEPS=markdown,shellcheck sh -c '
      cd "$1" || exit 1
      "$2" trailers add-skipped-trailer message || exit
      grep "^Skipped-Checks:" message
    ' sh "$TMP" "$GIT_HOOKS"
    The output should eq 'Skipped-Checks: markdown, shellcheck'
    The status should be success
  End

  It 'does not add a skipped-check trailer when no steps were skipped'
    When run command sh -c '
      cd "$1" || exit 1
      "$2" trailers add-skipped-trailer message || exit
      if grep -q "^Skipped-Checks:" message; then exit 1; fi
    ' sh "$TMP" "$GIT_HOOKS"
    The status should be success
  End

  It 'rejects a push option that disables CI'
    When run command env GIT_PUSH_OPTION_0=ci.skip "$GIT_HOOKS" community-health block-push-skip-ci
    The status should be failure
  End

  It 'rejects a pushed commit containing a CI skip marker'
    When run command sh -c '
      cd "$1" || exit 1
      printf "file\n" >tracked.txt
      git add tracked.txt
      git commit -q -m "feat: test [skip ci]" || exit
      commit=$(git rev-parse HEAD) || exit
      HK_HOOK_STDIN="refs/heads/topic $commit refs/heads/topic 0000000000000000000000000000000000000000" \
        "$2" community-health block-push-skip-ci
    ' sh "$TMP" "$GIT_HOOKS"
    The status should be failure
  End

  It 'adds and removes the configured SSH key through ssh-agent'
    When run command sh -c '
      cd "$1" || exit 1
      mkdir -p fakebin
      cat >fakebin/ssh-add <<EOF
#!/bin/sh
printf "%s\\n" "\$*" >>"$1/ssh-add.log"
EOF
      chmod +x fakebin/ssh-add
      : >id_ed25519
      git config gpg.format ssh
      git config user.signingKey "$1/id_ed25519"
      PATH="$1/fakebin:$PATH" "$2" signing add-ssh-key || exit
      PATH="$1/fakebin:$PATH" "$2" signing remove-ssh-key || exit
      cat ssh-add.log
    ' sh "$TMP" "$GIT_HOOKS"
    The output should include '-t 0'
    The output should include '-d'
    The status should be success
  End
End
