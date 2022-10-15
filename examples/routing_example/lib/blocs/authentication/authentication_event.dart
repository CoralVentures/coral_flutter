part of 'authentication_bloc.dart';

enum AuthenticationEvents {
  login,
  loginSucceeded,
  loginFailed,

  logout,
}

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent(this.eventType);

  final AuthenticationEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class AuthenticationEvent_Login extends AuthenticationEvent {
  const AuthenticationEvent_Login({
    required this.isAuthenticated,
  }) : super(AuthenticationEvents.login);

  /// Since the AuthenticationRepository is fake, we are simply passing in what
  /// we want the authentication response to be. I.e. this is just a hack.
  final bool isAuthenticated;

  @override
  List<Object> get props => super.props..add(isAuthenticated);
}

class AuthenticationEvent_LoginSucceeded extends AuthenticationEvent {
  const AuthenticationEvent_LoginSucceeded()
      : super(AuthenticationEvents.loginSucceeded);
}

class AuthenticationEvent_LoginFailed extends AuthenticationEvent {
  const AuthenticationEvent_LoginFailed()
      : super(AuthenticationEvents.loginFailed);
}

class AuthenticationEvent_Logout extends AuthenticationEvent {
  const AuthenticationEvent_Logout() : super(AuthenticationEvents.logout);
}
