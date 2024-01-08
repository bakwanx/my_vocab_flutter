import 'package:bloc/bloc.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/src/domain/usecase/home_usecase.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with MyVocabListener {
  HomeCubit({required HomeUseCase homeUseCase})
      : _homeUseCase = homeUseCase,
        super(HomeState.initial());

  final HomeUseCase _homeUseCase;

  Future<void> getVocabs() async {
    emit(state.copyWith(statusLoading: true));
    final result = await _homeUseCase.call();
    result.fold((l) {
      emit(state.copyWith(statusLoading: false, exception: l));
    }, (r) {
      emit(state.copyWith(statusLoading: false, vocabEntities: r));
    });
  }

  @override
  clearErrorState() {
    emit(state.copyWith(exception: null, statusLoading: false));
  }
}
