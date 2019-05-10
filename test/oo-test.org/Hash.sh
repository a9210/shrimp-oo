#!/bin/bash
source include.sh
source $(@import shrimp-oo shrimp-oo.sh)

AssertClass=$(@import shrimp-util Assert.sh)
assert=$(@new ${AssertClass})
Hash=$(@import shrimp-util Hash.sh)

rushHash=$(@new ${Hash})
@invoke ${rushHash}.put "vocal" "Geddy Lee"
@invoke ${rushHash}.put "bass" "Geddy Lee"
@invoke ${rushHash}.put "guiter" "Alex Lifeson"
@invoke ${rushHash}.put "drums" "Neil Peart"

yuraHash=$(@new ${Hash})
@invoke ${yuraHash}.put "vocal" "SAKAMOTO Shintaro"
@invoke ${yuraHash}.put "bass" "KAMEKAWA Chiyo"
@invoke ${yuraHash}.put "guiter" "SAKAMOTO Shintaro"
@invoke ${yuraHash}.put "drums" "SHIBATA Ichiro"

RESULT=$(@invoke ${rushHash}.get "vocal")
@invoke ${assert}.assert "${RESULT}" "Geddy Lee"
RESULT=$(@invoke ${rushHash}.get "bass")
@invoke ${assert}.assert "${RESULT}" "Geddy Lee"


RESULT=$(@invoke ${yuraHash}.get "vocal")
@invoke ${assert}.assert "${RESULT}" "SAKAMOTO Shintaro"
RESULT=$(@invoke ${yuraHash}.get "bass")
@invoke ${assert}.assert "${RESULT}" "KAMEKAWA Chiyo"

@delete ${rushHash}
@delete ${yuraHash}

# assert has couple of named pipe own itself
# delete doesn't clean fifo immediately
sleep 3
RESULT=$(find . -type p -name "*.fifo" | wc -l)
@invoke ${assert}.assert "${RESULT}" "2"

@invoke ${assert}.summary
RESULT=$?

@delete ${assert}

exit $((RESULT))