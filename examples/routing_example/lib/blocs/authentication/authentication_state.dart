// ignore_for_file: sort_constructors_first

part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  none,
  inProgress,
  authenticated,
  failed,
}

@JsonSerializable()
class AuthenticationState extends Equatable {
  const AuthenticationState({
    required this.status,
  });

  const AuthenticationState.initialState() : status = AuthenticationStatus.none;

  final AuthenticationStatus status;

  bool get isAuthenticated {
    return status == AuthenticationStatus.authenticated;
  }

  // coverage:ignore-start
  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationStateToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [status];
}
