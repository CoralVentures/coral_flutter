#!/usr/bin/env bash

set -e 

cd examples/biometrics_example
echo 'biometrics_example'
./tools/check_coverage.sh

cd ../bottom_nav_example
echo 'bottom_nav_example'
./tools/check_coverage.sh

cd ../counter_example
echo 'counter_example'
./tools/check_coverage.sh

cd ../data_layer_example
echo 'data_layer_example'
./tools/check_coverage.sh

cd ../double_yield_example
echo 'double_yield_example'
./tools/check_coverage.sh

cd ../flow_example
echo 'flow_example'
./tools/check_coverage.sh

cd ../routing_example
echo 'routing_example'
./tools/check_coverage.sh

cd ../todo_example
echo 'todo_example'
./tools/check_coverage.sh