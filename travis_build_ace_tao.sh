#!/bin/bash
BUILD_NAME=$1
export CXX=$COMPILER
mkdir ACE_TAO/build
cd ACE_TAO/build
echo BUILD_FLAGS=$BUILD_FLAGS


cmake -GNinja -C $TRAVIS_BUILD_DIR/ACE_TAO_for_DDS.cmake $BUILD_FLAGS .. && ninja -j 6 && ninja install
status=$?

cd ../..
tar -czf ace_tao.tar.gz ACE_TAO/build  --exclude=*.o
aws s3 cp ace_tao.tar.gz s3://com.ociweb.opendds/$TRAVIS_BRANCH/$BUILD_NAME/ace_tao.tar.gz

exit $status