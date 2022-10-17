// ignore_for_file: always_use_package_imports, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, lines_longer_than_80_chars
import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';

import './bloc_type.dart';
import './greetings/greetings_bloc.dart';
// CORAL_CLI_IMPORT

part 'redux_remote_devtools.g.dart';

bool shouldConnectReduxRemoteDevtools = false;
DevToolsStore<DevtoolsDb>? remoteReduxDevtoolsStore;

/// This mimics redux's AppDB so we can use redux's remote dev tools
DevtoolsDb devtoolsDB = const DevtoolsDb();

Future<DevToolsStore<DevtoolsDb>?> createReduxRemoteDevtoolsStore() async {
  if (shouldConnectReduxRemoteDevtools) {
    final reduxRemoteDevtools =
        RemoteDevToolsMiddleware<DevtoolsDb>('localhost:8001');

    await runZonedGuarded(
      () async {
        await reduxRemoteDevtools.connect();
      },
      (_, __) {},
    );

    /// Remote dev tools is listening for dispatch events from a redux store.
    /// However, we are not using redux at all. So to 'fake it', we are creating
    /// a store and then dispatching events from it so remote dev tools picks it
    /// up. The store is not used for anything else.
    final store = DevToolsStore<DevtoolsDb>(
      (_, action) => devtoolsDB,
      initialState: devtoolsDB,
      middleware: <Middleware<DevtoolsDb>>[reduxRemoteDevtools],
    );

    reduxRemoteDevtools.store = store;
    return store;
  }
  return null;
}

@JsonSerializable()
class DevtoolsDb {
  const DevtoolsDb({
    this.greetingsState,
    // CORAL_CLI_DB_THIS
  });

  // coverage:ignore-start
  factory DevtoolsDb.fromJson(Map<String, dynamic> json) =>
      _$DevtoolsDbFromJson(json);

  Map<String, dynamic> toJson() => _$DevtoolsDbToJson(this);
  // coverage:ignore-end

  final GreetingsState? greetingsState;
  // CORAL_CLI_DB_ATTR

  DevtoolsDb copyWith({
    GreetingsState? greetingsState,
    bool clearGreetingsState = false,
    // CORAL_CLI_COPY_WITH_PARAMETER
  }) {
    var _greetingsState = greetingsState ?? this.greetingsState;
    if (clearGreetingsState) {
      _greetingsState = null;
    }
    // CORAL_CLI_COPY_WITH_CLEAR

    return DevtoolsDb(
      greetingsState: _greetingsState,
      // CORAL_CLI_COPY_WITH_ARG
    );
  }
}

void remoteReduxDevtoolsOnEvent({
  required String blocType,
  required dynamic state,
  required dynamic event,
}) {
  if (shouldConnectReduxRemoteDevtools) {
    final blocTypeEnum = blocType.toEnum();

    switch (blocTypeEnum) {
      case BlocType.greetings:
        devtoolsDB = devtoolsDB.copyWith(
          greetingsState: state as GreetingsState,
        );
        break;
      // CORAL_CLI_ON_EVENT
    }

    remoteReduxDevtoolsStore?.dispatch(event.toString());
  }
}

void remoteReduxDevtoolsOnClose({
  required String blocType,
}) {
  if (shouldConnectReduxRemoteDevtools) {
    final blocTypeEnum = blocType.toEnum();

    switch (blocTypeEnum) {
      case BlocType.greetings:
        devtoolsDB = devtoolsDB.copyWith(clearGreetingsState: true);
        break;
      // CORAL_CLI_ON_CLOSE
    }
  }
}
