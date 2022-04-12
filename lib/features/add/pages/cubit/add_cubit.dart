import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:moja_apka/repositories/item_repository.dart';
import 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._itemsRepository)
      : super(
          const AddState(),
        );
  final ItemsRepository _itemsRepository;

  Future<void> add(
    String title,
    String aim,
    String imageURL,
    DateTime endDate,
  ) async {
    try {
      await _itemsRepository.add(title, aim, imageURL, endDate);
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
