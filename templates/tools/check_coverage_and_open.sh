#!/bin/sh

set -e

./tools/check_coverage.sh
open coverage/index.html