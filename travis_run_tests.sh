#!/bin/bash
BUILD_NAME=$1
aws s3 cp s3://com.ociweb.opendds/$TRAVIS_BRANCH/$BUILD_NAME/build.tar.gz .
tar zxf build.tar.gz
cd build
ctest -j 4
aws s3 cp Testing/Temporary/LastTest.log s3://com.ociweb.opendds/Logs/${TRAVIS_JOB_NUMBER}/LastTest.log
echo The log is available from http://com.ociweb.opendds.s3-website-us-east-1.amazonaws.com/Logs/${TRAVIS_JOB_NUMBER}/LastTest.log