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
      case AuthenticationEvents.initialize:
        {
          /// In a real application we might have an authentication token saved
          /// somewhere and we could check if it is still valid when the
          /// application loads. However, we are going to fake it and assume we
          /// always have a stale token.
          ///
          /// Note: if the authenticate method fails, we are going to silently
          /// ignore it, beacuse this wasn't an action taken by the user. It
          /// would be confusing to them to see a failure.
          yield* coralTryCatchStream<AuthenticationState>(
            tryFunc: () async* {
              final _isAuthenticated = _authenticationRepository.authenticate(
                isAuthenticated: false,
              );

              if (_isAuthenticated) {
                yield const AuthenticationState(
                  status: AuthenticationStatus.authenticated,
                );
              } else {
                yield const AuthenticationState(
                  status: AuthenticationStatus.none,
                );
              }
            },
          );
        }
        break;

      case AuthenticationEvents.login:
        yield* coralTryCatchStream<AuthenticationState>(
          tryFunc: () async* {
            yield const AuthenticationState(
              status: AuthenticationStatus.inProgress,
            );

            final _event = event as AuthenticationEvent_Login;

            final _isAuthenticated = _authenticationRepository.authenticate(
              isAuthenticated: _event.isAuthenticated,
            );

            /// Note: we are firing off events instead of setting the state
            /// directly. This is to give our analytics better visibility in to
            /// what is happening.
            if (_isAuthenticated) {
              add(AuthenticationEvent_LoginSucceeded());
            } else {
              add(AuthenticationEvent_LoginFailed());
            }
          },
          catchFunc: (e, stacktrace) async* {
            add(AuthenticationEvent_LoginFailed());
          },
        );
        break;

      case AuthenticationEvents.loginSucceeded:
        yield const AuthenticationState(
          status: AuthenticationStatus.authenticated,
        );
        break;

      /// Note: we are sending a status of `failed` followed by `none` because
      /// we want to hook off of the failed status, show a snack bar, and then
      /// have the status reset.
      case AuthenticationEvents.loginFailed:
        yield const AuthenticationState(
          status: AuthenticationStatus.failed,
        );

        yield const AuthenticationState(
          status: AuthenticationStatus.none,
        );
        break;

      case AuthenticationEvents.logout:
        yield const AuthenticationState(
          status: AuthenticationStatus.none,
        );
        break;
    }
  }
}
