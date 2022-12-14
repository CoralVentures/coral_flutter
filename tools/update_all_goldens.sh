#!/usr/bin/env bash

set -e 

cd examples/biometrics_example
echo 'biometrics_example'
./tools/goldens_update.sh

cd ../bottom_nav_example
echo 'bottom_nav_example'
./tools/goldens_update.sh

cd ../counter_example
echo 'counter_example'
./tools/goldens_update.sh

cd ../data_layer_example
echo 'data_layer_example'
./tools/goldens_update.sh

cd ../double_yield_example
echo 'double_yield_example'
./tools/goldens_update.sh

cd ../flow_example
echo 'flow_example'
./tools/goldens_update.sh

cd ../routing_example
echo 'routing_example'
./tools/goldens_update.sh

cd ../todo_example
echo 'todo_example'
./tools/goldens_update.sh