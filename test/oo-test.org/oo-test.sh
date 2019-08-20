#!/bin/bash
TEST_RESULT=0
source include.sh

cp ../../*.sh ./packages/shrimp-oo
shrimp install shrimp-util https://github.com/a9210/shrimp-util develop

./Hash.sh  || TEST_RESULT=1

source $(@import shrimp-oo shrimp-oo.sh)

AssertClass=$(@import shrimp-util Assert.sh)
assert=$(@new ${AssertClass})

echo "This is intensional assert error."
@invoke ${assert}.assert "1" "2"
RESULT=$?
@invoke ${assert}.assert "${RESULT}" "1"

echo "This is intensional assert error."
@invoke ${assert}.assert "1" "2"
echo "This is intensional assert error."
@invoke ${assert}.summary
RESULT=$?
@invoke ${assert}.assert "${RESULT}" "2" || TEST_RESULT=1

exit ${TEST_RESULT}
