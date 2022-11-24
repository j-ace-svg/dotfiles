# Aliases
alias sql='mysql --auto-vertical-output'
alias workbench='mysql-workbench-community'

# Interact with Music database from bash
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

# Completion for sql-music
_sql-music () {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=("add" "get")

    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${opts[*]}" -- ${cur}) )
    else
        case ${COMP_WORDS[1]} in
            "add")
                if [[ ${COMP_CWORD} -eq 2 ]]; then
                    COMPREPLY=( $(compgen -W "musician song" -- ${cur}) )
                fi
                ;;

            "get")
                if [[ ${COMP_CWORD} -eq 2 ]]; then
                    COMPREPLY=( $(compgen -W "musician song" -- ${cur}) )
                fi
                ;;

            *)
                ;;

        esac
    fi
    return 0

}

complete -F _sql-music sql-music
