#!/usr/bin/env bash

set -e 

flutter pub get packages/coral_analytics_repository
flutter pub get packages/coral_biomertics
flutter pub get packages/coral_bloc
flutter pub get packages/coral_bootstrap
flutter pub get packages/coral_cli
flutter pub get packages/coral_error_monitoring_repository
flutter pub get packages/coral_logger
flutter pub get packages/coral_poller
flutter pub get packages/coral_tester

flutter pub get examples/biometrics_example
flutter pub get examples/bottom_nav_example
flutter pub get examples/counter_example
flutter pub get examples/data_layer_example
flutter pub get examples/double_yield_example
flutter pub get examples/flow_example
flutter pub get examples/routing_example
flutter pub get examples/todo_example