#!/bin/bash

set -e

SOURCE_DIR=$(cd "$(dirname "$BASH_SOURCE")"; pwd)
: ${BUILD_DIR:=$SOURCE_DIR/build}

mkdir -p $BUILD_DIR
cp -r $SOURCE_DIR/thirdparty $BUILD_DIR
cd $BUILD_DIR
./thirdparty/download_thirdparty.sh
./thirdparty/build_thirdparty.sh

export SNAPPY_HOME=$BUILD_DIR/thirdparty/installed
export LZ4_HOME=$BUILD_DIR/thirdparty/installed
# build script doesn't support building thrift on OSX
if [ "$(uname)" != "Darwin" ]; then
  export THRIFT_HOME=$BUILD_DIR/thirdparty/installed
fi

cmake $SOURCE_DIR

cd $SOURCE_DIR

echo
echo "Build env initialized in $BUILD_DIR."

