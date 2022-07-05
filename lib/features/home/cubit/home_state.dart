part of 'home_cubit.dart';

@immutable
class HomeState {
  final Status status;
  final List<GoalModel> goalslist;
  final String? errorMessage;

  const HomeState({
    this.status = Status.initial,
    this.goalslist = const [],
    this.errorMessage,
  });
}
