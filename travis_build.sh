#!/bin/bash

if [ ${ANDROID} == "1" ]; then
  cat <<EOF > Toolchain.cmake
set(CMAKE_SYSTEM_NAME Android)
set(CMAKE_SYSTEM_VERSION $ANDROID_API_VERSION)

set(cross_triple arm-linux-androideabi)
set(CMAKE_ANDROID_STANDALONE_TOOLCHAIN $CROSS_ROOT/)
set(CMAKE_ANDROID_ARM_MODE 1)
set(CMAKE_ANDROID_ARM_NEON 1)

set(CMAKE_C_COMPILER $CROSS_ROOT/bin/clang)
set(CMAKE_CXX_COMPILER $CROSS_ROOT/bin/clang++)

set(CMAKE_FIND_ROOT_PATH $CROSS_ROOT)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_SYSROOT $CROSS_ROOT/sysroot)

EOF

  DDS_BUILD_FLAGS="${DDS_BUILD_FLAGS} -DCMAKE_TOOLCHAIN_FILE=$PWD/Toolchain.cmake"
fi

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
