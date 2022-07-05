import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:moja_apka/core/enums.dart';
import 'package:moja_apka/domain/model/goal_model.dart';
import 'package:moja_apka/domain/repositories/goal_repository.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._goalRepository) : super(const HomeState());

  final GoalRepository _goalRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async { emit(const HomeState(status: Status.loading));
    try {
    _streamSubscription = _goalRepository.getGoalsStream().listen(
      (goalslist) {
        emit(
          HomeState(goalslist: goalslist,
          status: Status.success ),
        );
      },
    );}catch (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> remove({required String documentID}) async { emit(const HomeState(status: Status.loading));
    try {
      await _goalRepository.remove(id: documentID);
    } catch (error) {
      emit(
         HomeState(status: Status.error,
        errorMessage: error.toString()),
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
