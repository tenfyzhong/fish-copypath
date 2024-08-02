function copypath --description 'copy path to clipboard'
    argparse -X 1 't/tail' 'h/help' -- $argv 2>/dev/null
    if test $status -ne 0
        return 1
    end

    if set -q _flag_help
        _copypath_help
        return 0
    end

    set -l target '.'
    if test (count $argv) -ne 0
        set target $argv[1]
        if test ! -e $target
            echo "copypath: can't copy path of '$target': No such file or directory" >&2
            return 2
        end
    end

    set path (realpath $target)
    set path (string trim -r $path)

    if set -q _flag_tail
        set path (basename $path)
    end

    echo -n $path | fish_clipboard_copy
end

function _copypath_help
    printf %s\n \
        'copypath: copy path to clipboard' \
        'Usage: copypath [path]' \
        '' \
        'Options:' \
        '  -t/--tail               get the tail part' \
        '  -h/--help               print this help message'
end
