// ignore_for_file: sort_constructors_first

part of 'authentication_bloc.dart';

@JsonSerializable()
class AuthenticationState extends Equatable {
  const AuthenticationState({
    required this.isAuthenticated,
  });

  const AuthenticationState.initialState() : isAuthenticated = false;

  final bool isAuthenticated;

  // coverage:ignore-start
  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationStateToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [isAuthenticated];
}
