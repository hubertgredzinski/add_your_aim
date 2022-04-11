part of 'home_cubit.dart';

@immutable
class HomeState {
  final List<ItemModel> goalslist;
  final bool loadingErrorOccured;
  final bool removingErroroccured;

  const HomeState({
    this.goalslist = const [],
    this.loadingErrorOccured = false,
    this.removingErroroccured = false,
  });
}
