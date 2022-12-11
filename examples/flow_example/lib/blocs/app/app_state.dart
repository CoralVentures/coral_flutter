// ignore_for_file: sort_constructors_first

part of 'app_bloc.dart';

enum AppFlows {
  home,
  createTodo,
}

@JsonSerializable()
class AppState extends Equatable {
  const AppState({
    required this.flow,
  });

  const AppState.initialState() : flow = AppFlows.home;

  // coverage:ignore-start
  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
  // coverage:ignore-end

  final AppFlows flow;

  @override
  List<Object?> get props => [flow];
}
