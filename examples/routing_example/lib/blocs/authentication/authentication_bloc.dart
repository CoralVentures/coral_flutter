// ignore_for_file: always_use_package_imports
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:routing_example/repositories/authentication/authentication_repository.dart';

import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'authentication_bloc.g.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends CoralBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          const AuthenticationState.initialState(),
          blocType: BlocType.authentication.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    switch (event.eventType) {
      case AuthenticationEvents.login:
        final _event = event as AuthenticationEvent_Login;

        final _isAuthenticated = _authenticationRepository.authenticate(
          isAuthenticated: _event.isAuthenticated,
        );

        yield AuthenticationState(isAuthenticated: _isAuthenticated);

        /// Note: we are firing off events instead of setting the state
        /// directly. This is to give our analytics better visibility in to what
        /// is happening.
        if (_isAuthenticated) {
          add(const AuthenticationEvent_LoginSucceeded());
        } else {
          add(const AuthenticationEvent_LoginFailed());
        }
        break;

      case AuthenticationEvents.loginSucceeded:
        yield const AuthenticationState(isAuthenticated: true);
        break;

      case AuthenticationEvents.loginFailed:
      case AuthenticationEvents.logout:
        yield const AuthenticationState(isAuthenticated: false);
        break;
    }
  }
}
