alias run='f(){ 2>/dev/null 1>&2 "$@" & disown "$!"; }; f'
alias switch='f(){ 2>/dev/null 1>&2 "$@" & disown "$!"; exit; }; f'
alias nv='nvim'
alias cu='f(){ cd ../"$@"; }; f'
alias reload='. ~/.bashrc'
alias files='run nautilus .'
alias dk='sudo docker'
alias g='git'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias c='config'
alias listen='mpv --no-video --loop=inf'

prettyjson-s() {
    echo "$1" | python3 -m json.tool
}

prettyjson-f() {
    python3 -m json.tool "$1"
}

prettyjson-w() {
    curl "$1" | python3 -m json.tool
}

bw-search() {
    local TEMP=`getopt --long -o "plh" "$@"`
    for i in $TEMP; do
        case "$i" in
    #while getopts "pl" opt; do
    #    case "$opt" in
            -p)
                local a=$(bw list "$1" --search "$2")
                prettyjson-s "$a"
                return 0
                ;;
            -l)
                local a=$(bw list "$1" --search "$2")
                [[ "$a" ]] && prettyjson-s "$a" | less
                return 0
                ;;
            --)
                local a=$(bw list "$1" --search "$2")
                [[ "$a" ]] && prettyjson-s "$a" | less
                return 0
                ;;
            -h)
                echo "Usage: $0 [-pl] [type] [search]" >&2
                return 1
                ;;
        esac
    done

}

if [ -f ~/.bash_aliases ]; then
    . ~/.mysql_aliases.sh
fi
