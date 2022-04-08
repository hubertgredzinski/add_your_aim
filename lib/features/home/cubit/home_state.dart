part of 'home_cubit.dart';

@immutable
class HomeState {
  final QuerySnapshot<Map<String, dynamic>>? goalslist;
  final bool loadingErrorOccured;
  final bool removingErroroccured;

  const HomeState({
    this.goalslist,
    this.loadingErrorOccured = false,
    this.removingErroroccured = false,
  });
}
