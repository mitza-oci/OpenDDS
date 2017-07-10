#!/bin/bash
BUILD_NAME=$1
export CXX=$COMPILER
mkdir build
cd build
echo DDS_BUILD_FLAGS=$DDS_BUILD_FLAGS

set -e
cmake -GNinja $DDS_BUILD_FLAGS .. && ninja -j $BUILD_JOBS

set +e
cd ..
tar  --exclude='*.o' -czf build.tar.gz build
aws s3 cp build.tar.gz s3://com.ociweb.opendds/$TRAVIS_BRANCH/$BUILD_NAME/build.tar.gz
