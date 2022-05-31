import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:moja_apka/repositories/goal_repository.dart';
import 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._goalRepository)
      : super(
          const AddState(),
        );
  final GoalRepository _goalRepository;

  Future<void> add(
    String title,
    String goal,
    String imageURL,
    DateTime endDate,
  ) async {
    try {
      await _goalRepository.add(title, goal, imageURL, endDate);
      emit(
        const AddState(saved: true),
      );
    } catch (error) {
      emit(
        AddState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
