import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'aims_state.dart';

class AimsCubit extends Cubit<AimsState> {
  AimsCubit()
      : super(
          const AimsState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

        StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const AimsState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

   _streamSubscription = FirebaseFirestore.instance.collection('goal').snapshots().listen((data) {
      emit(
        AimsState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })..onError((error) {
     emit(
        AimsState(
          documents: const [],
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    });
  }
   @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
