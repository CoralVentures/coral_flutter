#!/bin/bash

set -e

mkdir -p playground
cd playground

flutter create $1
cd $1

rm -rf linux macos test web windows lib
rm .gitignore analysis_options.yaml pubspec.yaml README.md

cp -R ../../templates/* .
cp -R ../../.vscode .
cp ../../.gitignore .
cp -R ../../examples/counter_example/lib .

mv test/flutter_test_config.dart_change_name test/flutter_test_config.dart
mv analysis_options.yaml_change_name analysis_options.yaml
mv pubspec.yaml_change_name pubspec.yaml

find . -type f -name '*.dart' -exec sed -i '' s/counter_example/$1/g {} +
sed -i '' -e "s/CHANGE_ME/$1/g" README.md
sed -i '' -e "s/CHANGE_ME/$1/g" pubspec.yaml
sed -i '' -e "s/CHANGE_ME/$1/g" mkdocs.yml

echo "---"
echo "Your coral_flutter application has been made."
echo ""
echo "  $ cd playground/$1"
echo ""