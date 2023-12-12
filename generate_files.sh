#!/bin/bash

cp lib/day0.ex lib/day$1.ex
cp test/day0_test.exs test/day$1_test.exs

touch test/testfiles/day$1_test.txt test/testfiles/day$1_input.txt