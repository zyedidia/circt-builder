#!/bin/bash

VERSION=main

cp circt/build/bin/firtool .
fpm -s dir -t deb -p firtool-$VERSION-amd64.deb --name firtool --license apache-2 --description 'FIRRTL to Verilog compiler' ./firtool=/usr/bin/firtool
