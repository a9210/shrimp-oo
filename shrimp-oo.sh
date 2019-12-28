#!/bin/bash
function @new() {
    local agentPath
    agentPath=$(@import shrimp-oo shrimp-oo-agent.sh)
    local ooPath
    ooPath=$(cd "$(dirname ${1})" && pwd)/$(basename ${1})
    ooPath=$(echo "${ooPath}" | sed "s/\/\//\//")
    {
    ooPath="${ooPath}"
    source "${ooPath}"
    source "${agentPath}"
    } > /dev/null &
    local OBJ_PID=$!
    echo "${ooPath}_${OBJ_PID}"
    for loopCount in seq 1 100
    do
        if [ -f "${ooPath}_${OBJ_PID}_stdin.fifo" ]
        then
            break
        fi
        sleep 0.1
    done
}
function @invoke() {
    local METHOD=$(echo $1 | awk -F. '{print $NF;}')
    local OBJ_PID=$(echo $1 | sed "s/\.${METHOD}$//")
    shift
    local OBJ_STDIN="${OBJ_PID}_stdin.fifo"
    local OBJ_STDOUT="${OBJ_PID}_stdout.fifo"

    local INVOKE_LINE="${METHOD} "
    for arg in "$@"
    do
        INVOKE_LINE="${INVOKE_LINE} \"${arg}\""
    done

    # invoke
    echo ${INVOKE_LINE} >> "${OBJ_STDIN}"

    # get output
    local IS_FIRST_LINE=true
    local isSecondLine=true
    local previusLine
    while read line
    do
        # First line is always dummy.
        if ${IS_FIRST_LINE}
        then
            IS_FIRST_LINE=false
            continue
        fi

        if ${isSecondLine}
        then
            isSecondLine=false
            previusLine=${line}
            continue
        fi
        echo ${previusLine}
        previusLine=${line}
    done < "${OBJ_STDOUT}"

    return $((previusLine))
}
function @flow() {
    local METHOD=$(echo $1 | awk -F. '{print $NF;}')
    local OBJ_PID=$(echo $1 | sed "s/\.${METHOD}$//")
    shift
    local OBJ_STDIN="${OBJ_PID}_stdin.fifo"
    local OBJ_STDOUT="${OBJ_PID}_stdout.fifo"

    local INVOKE_LINE="${METHOD} "
    for arg in "$@"
    do
        INVOKE_LINE="${INVOKE_LINE} \"${arg}\""
    done

    # invoke
    echo ${INVOKE_LINE} >> "${OBJ_STDIN}"

    # get output
    local IS_FIRST_LINE=true
    local isSecondLine=true
    local previusLine
    while read line
    do
        # First line is always dummy.
        if ${IS_FIRST_LINE}
        then
            IS_FIRST_LINE=false
            continue
        fi

        if ${isSecondLine}
        then
            isSecondLine=false
            previusLine=${line}
            continue
        fi
        echo ${previusLine}
        previusLine=${line}
    done < "${OBJ_STDOUT}"

    return $((previusLine))
}
function @delete {
    local OBJ_PID=$1
    echo "@delete" >> "${OBJ_PID}_stdin.fifo"
}
