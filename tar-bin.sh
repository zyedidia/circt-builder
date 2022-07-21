#!/bin/bash

VERSION=main

mkdir -p firtool-$VERSION
cp circt/build/bin/firtool ./firtool-$VERSION
cp circt/LICENSE ./firtool-$VERSION

tar -czf firtool-$VERSION.tar.gz ./firtool-$VERSION
