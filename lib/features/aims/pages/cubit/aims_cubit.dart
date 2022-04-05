import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'aims_state.dart';

class AimsCubit extends Cubit<AimsState> {
  AimsCubit()
      : super(
          const AimsState(
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

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
          'release_date': releaseDate
        },
      );
      emit(
        const AimsState(isLoading: false, errorMessage: ''),
      );
    } catch (error) {
      AimsState(isLoading: false, errorMessage: error.toString());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
