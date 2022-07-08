#!/bin/bash

REPO=https://github.com/llvm/circt
BUILD_TYPE=Release
ENABLE_ASSERTIONS=ON
EXPORT_COMPILE_COMMANDS=OFF

# get circt+llvm
git clone $REPO
cd circt
git submodule init
git submodule update

# build llvm
mkdir llvm/build
cd llvm/build
cmake -G Ninja ../llvm \
    -DLLVM_ENABLE_PROJECTS="mlir" \
    -DLLVM_TARGETS_TO_BUILD="host" \
    -DLLVM_ENABLE_ASSERTIONS=$ENABLE_ASSERTIONS \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=$EXPORT_COMPILE_COMMANDS
ninja

# build circt
cd ../../
mkdir build
cd build

cmake -G Ninja .. \
    -DMLIR_DIR=$PWD/../llvm/build/lib/cmake/mlir \
    -DLLVM_DIR=$PWD/../llvm/build/lib/cmake/llvm \
    -DLLVM_ENABLE_ASSERTIONS=$ENABLE_ASSERTIONS \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=$EXPORT_COMPILE_COMMANDS
ninja
