#!/bin/bash
function @new() {
    local agentPath=$(@import shrimp-oo shrimp-oo-agent.sh)
    {
    source ${1}
    source ${agentPath}
    } > /dev/null &
    local OBJ_PID=$!
    echo ${OBJ_PID}
    for loopCount in seq 1 100
    do
        if [ -f ${OBJ_PID}_stdin.fifo ]
        then
            break
        fi
        sleep 0.1
    done
}
function @invoke() {
    local OBJ_PID=$(echo $1 | awk -F. '{print $1;}')
    local METHOD=$(echo $1 | awk -F. '{print $2;}')
    shift
    local OBJ_STDIN=${OBJ_PID}_stdin.fifo
    local OBJ_STDOUT=${OBJ_PID}_stdout.fifo

    local INVOKE_LINE="${METHOD} "
    for arg in "$@"
    do
        INVOKE_LINE="${INVOKE_LINE} \"${arg}\""
    done

    # invoke
    echo ${INVOKE_LINE} >> ${OBJ_STDIN}

    # get output
    local IS_FIRST_LINE=true
    while read line
    do
        # First line is always dummy.
        if ${IS_FIRST_LINE}
        then
            IS_FIRST_LINE=false
            continue
        fi
        echo ${line}
    done < ${OBJ_STDOUT}
}
function @delete {
    local OBJ_PID=$1
    echo "@delete" >> ${OBJ_PID}_stdin.fifo
}