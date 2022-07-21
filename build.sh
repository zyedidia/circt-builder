#!/bin/bash

REPO=https://github.com/llvm/circt
BUILD_TYPE=Release
ENABLE_ASSERTIONS=OFF
EXPORT_COMPILE_COMMANDS=OFF
CHECKOUT=main

# get circt+llvm
git clone $REPO
git checkout $CHECKOUT
cd circt
git submodule init
git submodule update

# build llvm
mkdir llvm/build
cd llvm/build
cmake -G Ninja ../llvm \
    -DLLVM_ENABLE_PROJECTS="mlir" \
    -DLLVM_TARGETS_TO_BUILD="host" \
    -DLLVM_OPTIMIZED_TABLEGEN=ON \
    -DLLVM_STATIC_LINK_CXX_STDLIB=ON \
    -DLLVM_ENABLE_TERMINFO=OFF \
    -DLLVM_BUILD_EXAMPLES=OFF \
    -DLLVM_ENABLE_ASSERTIONS=OFF \
    -DLLVM_ENABLE_BINDINGS=OFF \
    -DLLVM_ENABLE_OCAMLDOC=OFF \
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
    -DLLVM_STATIC_LINK_CXX_STDLIB=ON \
    -DVERILATOR_DISABLE=ON \
    -DLLVM_ENABLE_TERMINFO=OFF && \
    -DLLVM_ENABLE_ASSERTIONS=$ENABLE_ASSERTIONS \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=$EXPORT_COMPILE_COMMANDS
ninja
