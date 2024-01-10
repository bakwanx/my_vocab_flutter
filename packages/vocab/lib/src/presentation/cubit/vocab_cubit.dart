import 'package:bloc/bloc.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';
import 'package:vocab/src/data/models/dto/vocab_dto.dart';
import 'package:vocab/src/domain/entity/type_vocab_entity.dart';
import 'package:vocab/src/domain/usecase/vocab_usecase.dart';
import 'package:vocab/src/presentation/cubit/vocab_state.dart';

class VocabCubit extends Cubit<VocabState> with MyVocabListener {
  VocabCubit({
    required VocabUseCase vocabUseCase,
    required MasterSharedPreferences masterSharedPreferences,
  })  : _vocabUseCase = vocabUseCase,
        _masterSharedPreferences = masterSharedPreferences,
        super(VocabState.initial());

  final VocabUseCase _vocabUseCase;
  final MasterSharedPreferences _masterSharedPreferences;

  Future<void> getDetailVocab(int idVocab) async {
    emit(state.copyWith(statusLoading: true));
    final result = await _vocabUseCase.getDetailVocab(idVocab: idVocab);
    result.fold((l) {
      emit(state.copyWith(statusLoading: false, exception: l));
    }, (r) {
      emit(state.copyWith(statusLoading: false, detailVocabEntity: r, typeVocabEntity: r.typeVocab));
    });
  }

  Future<void> getTypeVocabs() async {
    emit(state.copyWith(statusLoading: true));
    final result = await _vocabUseCase.getTypeVocabs();
    result.fold((l) {
      emit(state.copyWith(statusLoading: false, exception: l));
    }, (r) {
      emit(state.copyWith(statusLoading: false, typeVocabEntities: r));
    });
  }

  void setVocab({
    String? vocab,
    String? translation,
    TypeVocabEntity? typeVocabEntity,
    String? variation,
    String? note,
  }) {
    emit(state.copyWith(
      vocab: vocab,
      translation: translation,
      typeVocabEntity: typeVocabEntity,
      variation: variation,
      note: note,
    ));
    if (state.typeVocabEntity == null) {
      emit(state.copyWith(exception: Exception("Form tidak boleh kosong")));
    }
  }

  Future<void> postVocab() async {
    emit(state.copyWith(statusLoading: true));
    int idUser = 0;
    final userLocalModel = await _masterSharedPreferences.getUserLocalModel();
    idUser = userLocalModel.idUser;

    final result = await _vocabUseCase.postVocab(
        vocabDto: VocabDto(
          idUser: idUser,
          idType: state.typeVocabEntity!.idType,
          translation: state.translation!,
          vocab: state.vocab!,
          variation: state.variation!,
          note: state.note!,
        ));
    result.fold((l) {
      emit(state.copyWith(statusLoading: false, exception: l));
    }, (r) {
      emit(state.copyWith(statusLoading: false, isSuccess: true));
    });
  }

  Future<void> patchVocab(int idVocab) async {
    emit(state.copyWith(statusLoading: true));

    final result = await _vocabUseCase.patchVocab(
        vocabDto: VocabDto(
          idVocab: idVocab,
          idType: state.typeVocabEntity!.idType,
          translation: state.translation!,
          vocab: state.vocab!,
          variation: state.variation!,
          note: state.note!,
        ));
    result.fold((l) {
      emit(state.copyWith(statusLoading: false, exception: l));
    }, (r) {
      emit(state.copyWith(statusLoading: false, isSuccess: true));
    });
  }

  void setError(Exception exception) {
    emit(state.copyWith(exception: exception));
  }

  @override
  clearErrorState() {
    emit(state.copyWith(exception: null, statusLoading: false));
  }
}
