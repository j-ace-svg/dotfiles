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

# Aliases for sql
alias sql='mysql --auto-vertical-output'
alias workbench='mysql-workbench-community'
sql-music () {
    MODE=$1
    case $MODE in
        "add")
            TYPE=$2
            case $TYPE in
                "musician")
                    NAME=${3//\'/}
                    sql -D Music -e "INSERT INTO musicians (name) VALUES ('$NAME');"
                    ;;

                "song")
                    NAME=${3//\'/}
                    sql -D Music -e "INSERT INTO songs (name) VALUES ('$NAME');"
                    ;;

                *)
                    echo "Invalid type"
                    exit 1
            esac
            ;;

        "get")
            TYPE=$2
            case $TYPE in
                "musician")
                    sql -D Music -e "SELECT * FROM musicians;"
                    ;;

                "song")
                    sql -D Music -e "SELECT * FROM songs;"
                    ;;

                *)
                    echo "Invalid type"
                    exit 1
            esac
        ;;

        *)
            echo "Invalid mode"
            exit 1
    esac
}
