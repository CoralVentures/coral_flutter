part of 'authentication_bloc.dart';

enum AuthenticationEvents {
  biometricAuthenticationStarted,
  biometricAuthenticationFailed,
  biometricAuthenticationSucceeded,
}

abstract class AuthenticationEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  AuthenticationEvent(this.eventType);

  final AuthenticationEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class AuthenticationEvent_BiometricAuthenticationStarted
    extends AuthenticationEvent {
  AuthenticationEvent_BiometricAuthenticationStarted({
    required this.authDescription,
  }) : super(AuthenticationEvents.biometricAuthenticationStarted);

  final String authDescription;

  @override
  List<Object> get props => super.props..addAll([authDescription]);
}

class AuthenticationEvent_BiometricAuthenticationFailed
    extends AuthenticationEvent {
  AuthenticationEvent_BiometricAuthenticationFailed({
    required this.biometricsStatus,
  }) : super(AuthenticationEvents.biometricAuthenticationFailed);

  final CoralBiometricsStatus biometricsStatus;

  @override
  List<Object> get props => super.props..addAll([biometricsStatus]);
}

class AuthenticationEvent_BiometricAuthenticationSucceeded
    extends AuthenticationEvent {
  AuthenticationEvent_BiometricAuthenticationSucceeded()
      : super(AuthenticationEvents.biometricAuthenticationSucceeded);
}
