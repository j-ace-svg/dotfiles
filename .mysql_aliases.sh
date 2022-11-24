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
complete -W "add get" sql-music
