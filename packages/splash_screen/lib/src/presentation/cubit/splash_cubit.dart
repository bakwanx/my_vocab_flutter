import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:meta/meta.dart';
import 'package:splash_screen/src/presentation/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> with MyVocabListener {
  SplashCubit({required MasterSharedPreferences masterSharedPreferences})
      : _masterSharedPreferences = masterSharedPreferences,
        super(SplashState.initial());

  MasterSharedPreferences _masterSharedPreferences;

  Future<void> checkStatusLogin() async {
    emit(state.copyWith(
      statusLoading: false
    ));
    final result = await _masterSharedPreferences.getStatusLogin();
    Timer(const Duration(seconds: 2), () {
      if(result){
        emit(state.copyWith(
            statusLogin: true,
            statusLoading: false
        ));
      } else {
        emit(state.copyWith(
            statusLogin: false,
            statusLoading: false
        ));
      }
    });

  }

  @override
  clearErrorState() {
    emit(state.copyWith(exception: null, statusLoading: false));
  }
}
