#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

############################################################
# Help                                                     #
############################################################
help() {
    echo ""
    echo -e "Leverage docker stop to stop running processes. Note that there is no defualt set; this means if no option is provided, nothing will happen." | fmt
    echo
    echo -e "Ref: https://docs.docker.com/engine/reference/commandline/stop/"
    echo
    echo -e "Usage: $0 [ -f | -h ]" | fmt
    echo -e "\t-f\t Stop all running processes" | fmt
    echo -e "\t-h\t Display this help message" | fmt
    echo
}

############################################################
############################################################
# Main Program                                             #
############################################################
############################################################

DOCKER_COMMAND=""

while getopts "fh" opt; do
    case $opt in
    f)
        DOCKER_COMMAND="docker ps -aq | xargs docker stop"
        ;;
    h)
        help
        exit 0
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        help
        exit 1
        ;;
    :)
        echo ""
        echo "Option -$OPTARG requires an argument." >&2
        help
        exit 1
        ;;
    esac
done

eval "${DOCKER_COMMAND}"
