#!/bin/sh
Describe 'normalise_skipped_steps'
  It 'trims whitespace, removes empty entries and deduplicates names'
    When call normalise_skipped_steps ' markdown, shellcheck,,markdown '
    The output should eq 'markdown, shellcheck'
    The status should be success
  End

  It 'returns an empty value when no steps were skipped'
    When call normalise_skipped_steps ''
    The output should eq ''
    The status should be success
  End

  It 'rejects step names containing unsafe characters'
    When run normalise_skipped_steps 'bad name'
    The status should be failure
  End
End
