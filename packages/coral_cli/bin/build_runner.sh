#!/usr/bin/env bash

cd $1
dart run build_runner build --delete-conflicting-outputs

flutter clean
flutter pub get