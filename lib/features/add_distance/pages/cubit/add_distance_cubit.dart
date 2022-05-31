import 'package:bloc/bloc.dart';
import 'package:moja_apka/features/add_distance/pages/cubit/add_distance_state.dart';
import 'package:moja_apka/repositories/goal_repository.dart';

class AddDistanceCubit extends Cubit<AddDistanceState> {
  AddDistanceCubit(this._goalRepository)
      : super(
          const AddDistanceState(),
        );
 final GoalRepository _goalRepository;

  Future<void> add(
    String distance,
   )  async {
    try {
      await _goalRepository.distance(distance);
      emit(
        const AddDistanceState(saved: true),
      );
    } catch (error) {
      emit(
        AddDistanceState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
