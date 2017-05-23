#!/usr/bin/bash

cp Makefile bigint.ml bigint.mli maindc.ml scanner.mll testing
cd testing
mk.build
make clean
mk.test
rm *out
