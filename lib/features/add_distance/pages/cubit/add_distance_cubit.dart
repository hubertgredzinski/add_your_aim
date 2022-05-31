import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_distance_state.dart';

class AddDistanceCubit extends Cubit<AddDistanceState> {
  AddDistanceCubit() : super(AddDistanceInitial());
}
