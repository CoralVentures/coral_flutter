// ignore_for_file: sort_constructors_first

part of 'greetings_bloc.dart';

enum GreetingsHelloStatus { idle, sayHello }

@JsonSerializable()
class GreetingsState extends Equatable {
  const GreetingsState({
    required this.helloStatus,
  });

  final GreetingsHelloStatus helloStatus;

  const GreetingsState.initialState() : helloStatus = GreetingsHelloStatus.idle;

  // coverage:ignore-start
  factory GreetingsState.fromJson(Map<String, dynamic> json) =>
      _$GreetingsStateFromJson(json);

  Map<String, dynamic> toJson() => _$GreetingsStateToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [helloStatus];
}
