#!/usr/bin/env fish

set -gx PATH (pwd)/bin $PATH

set -l temp_dir (mktemp -d)
or exit 1

set -l message_file "$temp_dir/COMMIT_EDITMSG"
printf '%s\n' 'Test commit' > "$message_file"
or exit 1

git-hooks trailers add-config-trailer "$message_file"
or exit 1

grep -q '^Git-Hooks-Config: ' "$message_file"
or exit 1

rm -rf "$temp_dir"
echo "Fish CLI compatibility smoke test passed"
