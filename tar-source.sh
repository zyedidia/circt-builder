#!/bin/bash

CHECKOUT=main
VERSION=main
# CHECKOUT=sifive/1/10/0
# VERSION=1.10.0

cd circt
git checkout $CHECKOUT
git ls-files --recurse-submodules | tar caf ../circt-source-$VERSION.tar.gz -T- --xform s:^:circt/:
