#!/bin/bash
FIFO_STDIN=${BASHPID}_stdin.fifo
FIFO_STDOUT=${BASHPID}_stdout.fifo

mkfifo ${FIFO_STDIN}
mkfifo ${FIFO_STDOUT}
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
        echo "" > ${FIFO_STDOUT}        # dummy output for avoiding client halt when this method has no output
        echo "TeSt" > ${FIFO_STDOUT}        # dummy output for avoiding client halt when this method has no output
        eval ${line} > ${FIFO_STDOUT}
        echo "tEsT" > ${FIFO_STDOUT}        # dummy output for avoiding client halt when this method has no output
        echo "$?" > ${FIFO_STDOUT}      # send invoked function's return value
    done < ${FIFO_STDIN}
done

rm ${FIFO_STDIN}
rm ${FIFO_STDOUT}