import 'package:bloc/bloc.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/src/domain/entities/vocab_entity.dart';
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
      List<GroupEntity> groupsEntities = [];
      if(r.length <= 5){
        groupsEntities.add(GroupEntity(sequence: 1, vocabs: r));
      } else {
        int start = 0;
        int end = 5;
        final totalLength = r.length; // 12
        final modulus = totalLength % 5;
        final splitPage = modulus == 0 ? totalLength / 5 : (totalLength / 5 + 1).toInt(); // 3

        for (int i=1; i<= splitPage; i++) {
          if(i == splitPage){
            groupsEntities.add(GroupEntity(sequence: i, vocabs: r.getRange(start, totalLength).toList()));
          } else {
            groupsEntities.add(GroupEntity(sequence: i, vocabs: r.getRange(start, end).toList()));
            start = end;
            end  = end + 5;

          }
        }
        emit(state.copyWith(statusLoading: false, groupsEntities: groupsEntities));
      }

    });
  }

  Future<void> logOut() async {
    await _homeUseCase.logOut();
    emit(state.copyWith(isLogOut: true));
  }

  @override
  clearErrorState() {
    emit(state.copyWith(exception: null, statusLoading: false));
  }
}
