set -l cwd (mktemp -d)
set cwd (realpath $cwd)
cd $cwd
@echo "cwd:$cwd"

copypath
set -l data (fish_clipboard_paste)
@test 'test no args' "$data" = "$cwd"

copypath foo 2>/dev/null
@test 'test no exist' $status -eq 2

touch foo
copypath foo
set -l data (fish_clipboard_paste)
@test 'test file' "$data" = "$cwd/foo"
