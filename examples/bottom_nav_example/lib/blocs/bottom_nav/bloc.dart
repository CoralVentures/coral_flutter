// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'bloc.g.dart';

part 'event.dart';
part 'state.dart';

class BottomNavBloc extends CoralBloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc()
      : super(
          const BottomNavState.initialState(),
          blocType: BlocType.bottomNav.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  @override
  Stream<BottomNavState> mapEventToState(
    BottomNavEvent event,
  ) async* {
    switch (event.eventType) {
      case BottomNavEvents.toHome:
        yield const BottomNavState(tab: BottomNavTab.home);
        break;
      case BottomNavEvents.toSettings:
        yield const BottomNavState(tab: BottomNavTab.settings);
        break;
    }
  }
}
