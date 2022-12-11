#!/bin/sh

# To run in current directory:
# ./check_coverage
#
# To run in other directory:
# ./check_coverage ./path/to/other/project

set -e

PROJECT_PATH="${1:-.}"
PROJECT_COVERAGE=${PROJECT_PATH}/coverage/lcov.info
FILTERED_COVERAGE=${PROJECT_PATH}/coverage/filtered.info

rm -rf ./coverage
flutter test --no-pub --test-randomize-ordering-seed random --coverage --dart-define silenceAllLogs=true
lcov --remove ${PROJECT_COVERAGE} -o ${FILTERED_COVERAGE}\
    '**/*.g.dart' \
    '**/*.gr.dart' \
    '**/bloc_type.dart' \
    '**/redux_remote_devtools.dart'
genhtml ${FILTERED_COVERAGE} -o coverage