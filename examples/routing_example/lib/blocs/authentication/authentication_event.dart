part of 'authentication_bloc.dart';

enum AuthenticationEvents {
  initialize,

  login,
  loginSucceeded,
  loginFailed,

  logout,
}

abstract class AuthenticationEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  AuthenticationEvent(this.eventType);

  final AuthenticationEvents eventType;

  @override
  List<Object> get props => [eventType];
}

class AuthenticationEvent_Initialize extends AuthenticationEvent {
  AuthenticationEvent_Initialize() : super(AuthenticationEvents.initialize);
}

class AuthenticationEvent_Login extends AuthenticationEvent {
  AuthenticationEvent_Login({
    required this.isAuthenticated,
  }) : super(AuthenticationEvents.login);

  /// Since the AuthenticationRepository is fake, we are simply passing in what
  /// we want the authentication response to be. I.e. this is just a hack.
  final bool isAuthenticated;

  @override
  List<Object> get props => super.props..add(isAuthenticated);
}

class AuthenticationEvent_LoginSucceeded extends AuthenticationEvent {
  AuthenticationEvent_LoginSucceeded()
      : super(AuthenticationEvents.loginSucceeded);
}

class AuthenticationEvent_LoginFailed extends AuthenticationEvent {
  AuthenticationEvent_LoginFailed() : super(AuthenticationEvents.loginFailed);
}

class AuthenticationEvent_Logout extends AuthenticationEvent {
  AuthenticationEvent_Logout() : super(AuthenticationEvents.logout);
}
