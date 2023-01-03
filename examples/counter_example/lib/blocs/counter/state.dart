// ignore_for_file: sort_constructors_first

part of 'bloc.dart';

@JsonSerializable()
class CounterState extends Equatable {
  const CounterState({
    required this.count,
  });

  const CounterState.initialState() : count = 0;

  final int count;

  // coverage:ignore-start
  factory CounterState.fromJson(Map<String, dynamic> json) =>
      _$CounterStateFromJson(json);

  Map<String, dynamic> toJson() => _$CounterStateToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [count];
}
