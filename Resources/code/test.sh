#!/usr/bin/bash

cp Makefile bigint.ml bigint.mli maindc.ml scanner.mll testing
cd testing
/afs/cats.ucsc.edu/courses/cmps012b-wm/bin/checksource bigint.ml
/afs/cats.ucsc.edu/courses/cmps012b-wm/bin/checksource maindc.ml
mk.build
make clean
mk.test
