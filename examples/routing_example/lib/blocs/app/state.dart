// ignore_for_file: sort_constructors_first

part of 'bloc.dart';

enum AppRoutes { home, about }

@JsonSerializable()
class AppState extends Equatable {
  const AppState({
    required this.route,
  });

  const AppState.initialState() : route = AppRoutes.home;

  // coverage:ignore-start
  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
  // coverage:ignore-end

  final AppRoutes route;

  @override
  List<Object?> get props => [route];
}
