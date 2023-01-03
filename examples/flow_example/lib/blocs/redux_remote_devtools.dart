// ignore_for_file: always_use_package_imports, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, lines_longer_than_80_chars
import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';

import './bloc_type.dart';
import 'app/bloc.dart';
import 'create_todo/bloc.dart';
import 'todos/bloc.dart';

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
    this.createTodoState,
    this.todosState,
    this.appState,
    // CORAL_CLI_DB_THIS
  });

  // coverage:ignore-start
  factory DevtoolsDb.fromJson(Map<String, dynamic> json) =>
      _$DevtoolsDbFromJson(json);

  Map<String, dynamic> toJson() => _$DevtoolsDbToJson(this);
  // coverage:ignore-end

  final CreateTodoState? createTodoState;
  final TodosState? todosState;
  final AppState? appState;
  // CORAL_CLI_DB_ATTR

  DevtoolsDb copyWith({
    CreateTodoState? createTodoState,
    bool clearCreateTodoState = false,
    TodosState? todosState,
    bool clearTodosState = false,
    AppState? appState,
    bool clearAppState = false,
    // CORAL_CLI_COPY_WITH_PARAMETER
  }) {
    var _createTodoState = createTodoState ?? this.createTodoState;
    if (clearCreateTodoState) {
      _createTodoState = null;
    }
    var _todosState = todosState ?? this.todosState;
    if (clearTodosState) {
      _todosState = null;
    }
    var _appState = appState ?? this.appState;
    if (clearAppState) {
      _appState = null;
    }
    // CORAL_CLI_COPY_WITH_CLEAR

    return DevtoolsDb(
      createTodoState: _createTodoState,
      todosState: _todosState,
      appState: _appState,
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
    final blocTypeEnum = blocType.toBlocTypeEnum();

    switch (blocTypeEnum) {
      case BlocType.createTodo:
        devtoolsDB = devtoolsDB.copyWith(
          createTodoState: state as CreateTodoState,
        );
        break;
      case BlocType.todos:
        devtoolsDB = devtoolsDB.copyWith(
          todosState: state as TodosState,
        );
        break;
      case BlocType.app:
        devtoolsDB = devtoolsDB.copyWith(
          appState: state as AppState,
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
    final blocTypeEnum = blocType.toBlocTypeEnum();

    switch (blocTypeEnum) {
      case BlocType.createTodo:
        devtoolsDB = devtoolsDB.copyWith(clearCreateTodoState: true);
        break;
      case BlocType.todos:
        devtoolsDB = devtoolsDB.copyWith(clearTodosState: true);
        break;
      case BlocType.app:
        devtoolsDB = devtoolsDB.copyWith(clearAppState: true);
        break;
      // CORAL_CLI_ON_CLOSE
    }
  }
}
