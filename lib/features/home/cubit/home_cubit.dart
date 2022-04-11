import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:moja_apka/model/item_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription =
        FirebaseFirestore.instance.collection('goal').snapshots().listen(
      (goalslist) {
        final itemModels = goalslist.docs.map((doc) {
          return ItemModel(
            title: doc['title'],
            imageURL: doc['image_url'],
            aim: doc['aim'],
            releaseDate: doc['release_date'],
          );
        }).toList();
        emit(
          HomeState(goalslist: itemModels),
        );
      },
    )..onError(
            (error) {
              emit(
                const HomeState(
                  loadingErrorOccured: true,
                ),
              );
            },
          );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('goal')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(
        const HomeState(loadingErrorOccured: true),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
