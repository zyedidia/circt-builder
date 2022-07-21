#!/bin/bash

REPO=https://github.com/llvm/circt
CHECKOUT=sifive/1/10/0
VERSION=1.10.0

git clone $REPO circt-source
cd circt-source
git checkout $CHECKOUT
git submodule init
git submodule update
git ls-files --recurse-submodules | tar caf ../circt-source-$VERSION.tar.gz -T- --xform s:^:circt/:
