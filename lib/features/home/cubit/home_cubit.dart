import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:moja_apka/app/core/enums.dart';
import 'package:moja_apka/domain/model/goal_model.dart';
import 'package:moja_apka/domain/repositories/goal_repository.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.goalRepository}) : super(const HomeState());

  final GoalRepository goalRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const HomeState(status: Status.loading));
    try {
      _streamSubscription = goalRepository.getGoalsStream().listen(
        (goalslist) {
          emit(
            HomeState(goalslist: goalslist, status: Status.success),
          );
        },
      );
    } catch (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> remove({required String documentID}) async {
    emit(const HomeState(status: Status.loading));
    try {
      await goalRepository.remove(id: documentID);
    } catch (error) {
      emit(
        HomeState(status: Status.error, errorMessage: error.toString()),
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
