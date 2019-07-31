#!/bin/bash
function @self {
    echo "${ooPath}_${BASHPID}"
}
FIFO_STDIN=$(@self)_stdin.fifo
FIFO_STDOUT=$(@self)_stdout.fifo

mkfifo "${FIFO_STDIN}"
mkfifo "${FIFO_STDOUT}"
LOOP_FLAG=true
while ${LOOP_FLAG}
do
    while read line
    do
        if [ "${line}" = "@delete" ]
        then
            LOOP_FLAG=false
            break
        fi

        {
            echo ""                     # dummy output for avoiding client halt when this method has no output
            eval ${line}
            echo "$?"                   # send invoked function's return value
        } >> "${FIFO_STDOUT}"        

    done < "${FIFO_STDIN}"
done

rm "${FIFO_STDIN}"
rm "${FIFO_STDOUT}"
