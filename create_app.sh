#!/bin/bash

set -e

mkdir -p playground
cd playground

flutter create $1
cd $1

rm -rf linux macos test web windows lib
rm .gitignore analysis_options.yaml pubspec.yaml README.md

cp -R ../../templates/* .
cp -R ../../templates/.vscode .
cp ../../templates/.gitignore .
cp -R ../../examples/counter_example/lib .
cp -R ../../examples/counter_example/test .

mv analysis_options.yaml_change_name analysis_options.yaml
mv pubspec.yaml_change_name pubspec.yaml

find . -type f -name '*.dart' -exec sed -i '' s/counter_example/$1/g {} +

sed -i '' -e "s/CHANGE_ME/$1/g" README.md
sed -i '' -e "s/CHANGE_ME/$1/g" pubspec.yaml
sed -i '' -e "s/CHANGE_ME/$1/g" mkdocs.yml

sed -i '' -e "s/change-me-dev-segment/${DEV_SEGMENT_API_WRITE_KEY:-change-me-dev-segment}/g" lib/main/main_configuration.dart 
sed -i '' -e "s~change-me-dev-sentry~${DEV_SENTRY_DSN:-change-me-dev-sentry}~g" lib/main/main_configuration.dart 

echo "---"
echo "Your coral_flutter application has been made."
echo ""
echo "  $ cd playground/$1"
echo ""