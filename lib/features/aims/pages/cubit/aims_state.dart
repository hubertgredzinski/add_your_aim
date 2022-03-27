part of 'aims_cubit.dart';

@immutable
class AimsState {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final bool isLoading;
  final String errorMessage;

  const AimsState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
