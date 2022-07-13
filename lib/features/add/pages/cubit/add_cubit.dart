import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moja_apka/domain/repositories/goal_repository.dart';
import 'add_state.dart';

@injectable
class AddCubit extends Cubit<AddState> {
  AddCubit({required this.goalRepository})
      : super(
          const AddState(),
        );
  final GoalRepository goalRepository;

  Future<void> add(
    String title,
    String goal,
    String unit,
    String imageURL,
    DateTime endDate,
  ) async {
    try {
      await goalRepository.add(title, goal, unit, imageURL, endDate);
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
