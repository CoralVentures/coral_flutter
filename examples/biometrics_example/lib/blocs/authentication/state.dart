// ignore_for_file: sort_constructors_first

part of 'bloc.dart';

@JsonSerializable()
class AuthenticationState extends Equatable {
  const AuthenticationState({
    required this.biometricsStatus,
  });

  const AuthenticationState.initialState()
      : biometricsStatus = CoralBiometricsStatus.unknown;

  final CoralBiometricsStatus biometricsStatus;

  // coverage:ignore-start
  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationStateToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [biometricsStatus];
}
