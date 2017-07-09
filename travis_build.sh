#!/bin/bash
BUILD_NAME=$1
export CXX=$COMPILER
mkdir build
cd build
echo DDS_BUILD_FLAGS=$DDS_BUILD_FLAGS

cmake -GNinja $DDS_BUILD_FLAGS .. && ninja -j $BUILD_JOBS
status=$?

cd ..
tar -czf build.tar.gz build  --exclude=*.o
aws s3 cp build.tar.gz s3://com.ociweb.opendds/$TRAVIS_BRANCH/$BUILD_NAME/build.tar.gz


exit $status