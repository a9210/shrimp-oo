#!/bin/bash
source include.sh

TEST_RESULT=0

cp -pr ./test/oo-test.org ./test/oo-test
(cd ./test/oo-test;./oo-test.sh) || TEST_RESULT=1
#@call ./test/oo-test/oo-test.sh || TEST_RESULT=1
rm -rf ./test/oo-test

exit ${TEST_RESULT}
