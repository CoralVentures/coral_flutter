// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'bloc.g.dart';

part 'event.dart';
part 'state.dart';

class AppBloc extends CoralBloc<AppEvent, AppState> {
  AppBloc()
      : super(
          const AppState.initialState(),
          blocType: BlocType.app.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    switch (event.eventType) {
      case AppEvents.toHomePage:
        yield const AppState(route: AppRoutes.home);
        break;
      case AppEvents.toAboutPage:
        yield const AppState(route: AppRoutes.about);
        break;
    }
  }
}
