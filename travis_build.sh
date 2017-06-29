#!/bin/bash
BUILD_NAME=$1
export CXX=$COMPILER
mkdir build
cd build
echo DDS_BUILD_FLAGS=$DDS_BUILD_FLAGS
# - printf "max_size=450M\nsloppiness=include_file_ctime;include_file_mtime" > ~/.ccache/ccache.conf

if [ "$CCACHE" == "1" ]; then
    aws s3 sync --quiet s3://com.ociweb.opendds/$TRAVIS_BRANCH/$BUILD_NAME/.ccache ~/.ccache || true
fi

cmake -GNinja $DDS_BUILD_FLAGS .. && ninja -j 6
cd ..
tar -czf build.tar.gz build  --exclude=*.o
aws s3 cp build.tar.gz s3://com.ociweb.opendds/$TRAVIS_BRANCH/$BUILD_NAME/build.tar.gz

if [ "$CCACHE" == "1" ]; then
    aws s3 sync --quiet --delete s3://com.ociweb.opendds/$TRAVIS_BRANCH/$BUILD_NAME/.ccache ~/.ccache || true
fi
