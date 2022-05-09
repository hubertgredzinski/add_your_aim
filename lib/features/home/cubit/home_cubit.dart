import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:moja_apka/model/goal_model.dart';
import 'package:moja_apka/repositories/goal_repository.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._goalRepository) : super(const HomeState());

  final GoalRepository _goalRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _goalRepository.getGoalsStream().listen(
      (goalslist) {
        emit(
          HomeState(goalslist: goalslist),
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
      await _goalRepository.remove(id: documentID);
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
