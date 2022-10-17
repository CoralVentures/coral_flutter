#!/bin/bash

# To run in current directory:
# ./check_coverage
#
# To run in other directory:
# ./check_coverage ./path/to/other/project

set -e

if ! [ -x "$(command -v format_coverage)" ]; then
  echo "coverage not found, installing to use format_coverage"
  pub global activate coverage
  export PATH="$PATH":"$HOME/.pub-cache/bin"
fi

PROJECT_PATH="${1:-.}"
PROJECT_COVERAGE=${PROJECT_PATH}/coverage/lcov.info
FILTERED_COVERAGE=${PROJECT_PATH}/coverage/lcov_filtered.info

rm -rf ./coverage
dart run test --coverage=coverage --test-randomize-ordering-seed=random 

format_coverage --packages=${PROJECT_PATH}/.dart_tool/package_config.json --report-on lib -i ${PROJECT_PATH}/coverage -l -o ${PROJECT_PATH}/coverage/lcov.info

lcov --remove ${PROJECT_COVERAGE} -o ${FILTERED_COVERAGE} '**/*.g.dart' 

genhtml ${FILTERED_COVERAGE} -o coverage