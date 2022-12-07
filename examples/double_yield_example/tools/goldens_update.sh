#!/bin/bash

set -e

# remove gallery directory
rm -rf test/gallery

# remove golden directories
cd test/user_stories
find . -type d -name "goldens" -exec rm -rf {} +

# generate new goldens
cd ../../
flutter test --update-goldens test/user_stories

# go back to original directory
cd ../..
