import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_value_state.dart';

class ChangeValueCubit extends Cubit<ChangeValueState> {
  ChangeValueCubit() : super(ChangeValueState());
}
