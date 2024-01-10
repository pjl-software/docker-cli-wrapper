#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

############################################################
# Help                                                     #
############################################################
help() {
    echo ""
    echo -e "Print out the container ID given a partial or complete string." | fmt
    echo
    echo -e "Ref: https://docs.docker.com/engine/reference/commandline/ps/"
    echo
    echo -e "Usage: $0 [ -h | -i ]" | fmt
    echo -e "\t-h\t Display this help message" | fmt
    echo -e "\t-i\t Partial or complete Image name." | fmt
    echo
}

############################################################
############################################################
# Main Program                                             #
############################################################
############################################################

isBlankCheck() {
    CONTAINER_ID_VALUE_TO_CHECK=$1
    VALUE_USED_TO_SEARCH=$2

    if [ -z "${CONTAINER_ID_VALUE_TO_CHECK}" ]; then
        echo "There is no image container ID. Are you sure ${VALUE_USED_TO_SEARCH} is running? Double check by running $ docker ps"
        exit 1
    fi

    echo "${CONTAINER_ID_VALUE_TO_CHECK}"
    exit 0
}

IMAGE_NAME_TO_SEARCH=""
IMAGE_NAME_TO_SEARCH_CONTAINER_ID=""

while getopts "hi:" opt; do
    case $opt in
    h)
        help
        exit 0
        ;;
    i)
        IMAGE_NAME_TO_SEARCH=$OPTARG
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

IMAGE_NAME_TO_SEARCH_CONTAINER_ID=$(docker ps --filter "name=${IMAGE_NAME_TO_SEARCH}" -q)
isBlankCheck "${IMAGE_NAME_TO_SEARCH_CONTAINER_ID}" "${IMAGE_NAME_TO_SEARCH}"
