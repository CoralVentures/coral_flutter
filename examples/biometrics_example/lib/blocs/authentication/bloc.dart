// ignore_for_file: always_use_package_imports
import 'package:coral_biometrics_repository/coral_biometrics_repository.dart';
import 'package:coral_bloc/coral_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../bloc_type.dart';
import '../redux_remote_devtools.dart';

part 'bloc.g.dart';

part 'event.dart';
part 'state.dart';

class AuthenticationBloc
    extends CoralBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.biometricsRepository,
  }) : super(
          const AuthenticationState.initialState(),
          blocType: BlocType.authentication.name,
          beforeOnEvent: remoteReduxDevtoolsOnEvent,
          beforeOnClose: remoteReduxDevtoolsOnClose,
        );

  final CoralBiometricsRepository biometricsRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    switch (event.eventType) {
      case AuthenticationEvents.biometricAuthenticationStarted:
        final _event =
            event as AuthenticationEvent_BiometricAuthenticationStarted;

        var biometricsStatus = CoralBiometricsStatus.unknown;

        yield AuthenticationState(
          biometricsStatus: biometricsStatus,
        );

        await coralTryCatch(
          tryFunc: () async {
            biometricsStatus =
                await biometricsRepository.authenticateWithBiometrics(
              authDescription: _event.authDescription,
            );
          },
          catchFunc: (_, __) async {
            biometricsStatus = CoralBiometricsStatus.authenticationFailed;
          },
        );

        switch (biometricsStatus) {
          case CoralBiometricsStatus.unknown:
          case CoralBiometricsStatus.unsupported:
          case CoralBiometricsStatus.supportedButNotSetUp:
          case CoralBiometricsStatus.authenticationFailed:
            add(
              AuthenticationEvent_BiometricAuthenticationFailed(
                biometricsStatus: biometricsStatus,
              ),
            );
            break;
          case CoralBiometricsStatus.authenticationPassed:
            add(AuthenticationEvent_BiometricAuthenticationSucceeded());
            break;
        }
        break;

      case AuthenticationEvents.biometricAuthenticationFailed:
        final _event =
            event as AuthenticationEvent_BiometricAuthenticationFailed;
        yield AuthenticationState(
          biometricsStatus: _event.biometricsStatus,
        );
        break;

      case AuthenticationEvents.biometricAuthenticationSucceeded:
        yield const AuthenticationState(
          biometricsStatus: CoralBiometricsStatus.authenticationPassed,
        );
        break;
    }
  }
}
