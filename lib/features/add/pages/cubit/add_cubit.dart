import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit()
      : super(
          const AddState(),
        );

  Future<void> add(
    String title,
    String aim,
    String imageURL,
    DateTime releaseDate,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('goal').add(
        {
          'title': title,
          'aim': aim,
          'image_url': imageURL,
          'release_date': releaseDate,
        },
      );
      emit(
        const AddState(saved: true),
      );
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}