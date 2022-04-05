part of 'home_cubit.dart';

@immutable
class HomeState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const HomeState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
