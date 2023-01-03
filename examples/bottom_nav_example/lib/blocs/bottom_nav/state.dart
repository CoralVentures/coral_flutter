// ignore_for_file: sort_constructors_first

part of 'bloc.dart';

// Order enum values in the order of tabs from left to right
enum BottomNavTab {
  home, // index 0
  settings, // index 1
}

@JsonSerializable()
class BottomNavState extends Equatable {
  const BottomNavState({
    required this.tab,
  });

  final BottomNavTab tab;

  const BottomNavState.initialState() : tab = BottomNavTab.home;

  // coverage:ignore-start
  factory BottomNavState.fromJson(Map<String, dynamic> json) =>
      _$BottomNavStateFromJson(json);

  Map<String, dynamic> toJson() => _$BottomNavStateToJson(this);
  // coverage:ignore-end

  @override
  List<Object?> get props => [tab];
}
