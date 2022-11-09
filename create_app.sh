#!/bin/bash

set -e

mkdir -p playground
cd playground

flutter create $1
cd $1

rm -rf linux macos test web windows lib
rm .gitignore analysis_options.yaml pubspec.yaml README.md

cp -R ../../examples/counter_example/.vscode .
cp -R ../../examples/counter_example/lib .
cp -R ../../examples/counter_example/test .
cp -R ../../examples/counter_example/tools .

cp ../../examples/counter_example/.gitignore .
cp ../../examples/counter_example/analysis_options.yaml .
cp ../../examples/counter_example/dart_test.yaml .
cp ../../examples/counter_example/l10n.yaml .
cp ../../examples/counter_example/mkdocs.yml .
cp ../../examples/counter_example/pubspec.yaml .
cp ../../examples/counter_example/README.md .

find . -type f -name '*.dart' -exec sed -i '' s/counter_example/$1/g {} +
find . -type f -name '*.yaml' -exec sed -i '' s/counter_example/$1/g {} +
find . -type f -name '*.yml' -exec sed -i '' s/counter_example/$1/g {} +
find . -type f -name '*.md' -exec sed -i '' s/counter_example/$1/g {} +

sed -i '' -e "s/change-me-dev-segment/${DEV_SEGMENT_API_WRITE_KEY:-change-me-dev-segment}/g" lib/main/main_configuration.dart
sed -i '' -e "s~change-me-dev-sentry~${DEV_SENTRY_DSN:-change-me-dev-sentry}~g" lib/main/main_configuration.dart

echo "\n\n---"
echo "Your coral_flutter application has been made."
echo ""
echo "  $ cd playground/$1"
echo ""