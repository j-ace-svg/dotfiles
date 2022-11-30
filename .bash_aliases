alias run='f(){ 2>/dev/null 1>&2 "$@" & disown "$!"; }; f'
alias switch='f(){ 2>/dev/null 1>&2 "$@" & disown "$!"; exit; }; f'
alias nv='nvim'
alias cu='cd ..'
alias reload='. ~/.bashrc'
alias files='run nautilus .'
alias dk='sudo docker'
alias g='git'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias c='config'
alias listen='mpv --no-video --loop=inf'

prettyjson_s() {
    echo "$1" | python3 -m json.tool
}

prettyjson_f() {
    python3 -m json.tool "$1"
}

prettyjson_w() {
    curl "$1" | python3 -m json.tool
}

source .mysql_aliases.sh
