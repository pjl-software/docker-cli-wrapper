#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
DOCKER_SHORTCUT_SCRIPT_ENV_FILE="${SCRIPT_DIR}/.docker-shortcut-script-env"

. "${DOCKER_SHORTCUT_SCRIPT_ENV_FILE}"

############################################################
# Help                                                     #
############################################################
help() {
    echo ""
    echo -e "Grab the logs for a running container." | fmt
    echo
    echo -e "Ref: https://docs.docker.com/engine/reference/commandline/logs/"
    echo
    echo -e "Usage: $0 [ -f | -h | -i |-t ]" | fmt
    echo -e "\t-f\t Enable the follow option, which will leave the logs running." | fmt
    echo -e "\t-h\t Display this help message" | fmt
    echo -e "\t-i\t Runing image container ID (can be pulled from running 'docker ps')" | fmt
    echo -e "\t-t\t Docker image name (can be a partial or complete match) to try and log in to (can be found  running 'docker ps')" | fmt
    echo
}

############################################################
############################################################
# Main Program                                             #
############################################################
############################################################

COMMAND="docker logs"
DOCKER_RUN_COMMAND=""

while getopts "fhit::" opt; do
    case $opt in
    f)
        DOCKER_RUN_COMMAND="--follow"
        ;;
    t)
        echo "Checking for running Docker services that match, or partial match: ${OPTARG}"
        RUNNING_IMAGE_CONTAINER_ID=$(runningImageContainerWrapperScript "-i" "${OPTARG}")
        echo "${RUNNING_IMAGE_CONTAINER_ID}"
        ;;
    h)
        help
        exit 0
        ;;
    i)
        RUNNING_IMAGE_CONTAINER_ID=$OPTARG
        echo "Attempting to access Container ID: ${RUNNING_IMAGE_CONTAINER_ID}"
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

eval "${COMMAND}" "${DOCKER_RUN_COMMAND}" "${RUNNING_IMAGE_CONTAINER_ID}"
