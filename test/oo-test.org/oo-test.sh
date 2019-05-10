#!/bin/bash
TEST_RESULT=0
source include.sh

cp ../../*.sh ./packages/shrimp-oo
shrimp install shrimp-util https://github.com/a9210/shrimp-util develop

./Hash.sh  || TEST_RESULT=1


exit ${TEST_RESULT}
