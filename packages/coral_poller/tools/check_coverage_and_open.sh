#!/bin/bash

# To run in current directory:
# ./check_coverage
#
# To run in other directory:
# ./check_coverage ./path/to/other/project

set -e

./tools/check_coverage.sh
open coverage/index.html