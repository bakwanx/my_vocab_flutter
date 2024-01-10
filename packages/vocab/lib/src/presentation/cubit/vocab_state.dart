import 'package:common_dependency/common_dependency.dart';
import 'package:vocab/src/domain/entity/type_vocab_entity.dart';
import 'package:vocab/src/domain/entity/vocab_entity.dart';

class VocabState implements MyVocabState {
  final Exception? exception;
  final bool statusLoading;
  final List<TypeVocabEntity> typeVocabEntities;
  final VocabEntity? detailVocabEntity;
  final String? vocab;
  final String? translation;
  final TypeVocabEntity? typeVocabEntity;
  final String? variation;
  final String? note;
  final bool isSuccess;

  VocabState({
    required this.statusLoading,
    required this.exception,
    required this.typeVocabEntities,
    required this.detailVocabEntity,
    this.vocab,
    this.translation,
    this.typeVocabEntity,
    this.variation,
    this.note,
    required this.isSuccess,
  });

  factory VocabState.initial() => VocabState(
        statusLoading: false,
        exception: null,
        typeVocabEntities: [],
        isSuccess: false,
    detailVocabEntity: null,
      );

  VocabState copyWith({
    Exception? exception,
    bool? statusLoading,
    List<TypeVocabEntity>? typeVocabEntities,
    VocabEntity? detailVocabEntity,
    String? vocab,
    String? translation,
    TypeVocabEntity? typeVocabEntity,
    String? variation,
    String? note,
    bool? isSuccess,
  }) =>
      VocabState(
        statusLoading: statusLoading ?? this.statusLoading,
        exception: exception ?? this.exception,
        typeVocabEntities: typeVocabEntities ?? this.typeVocabEntities,
        detailVocabEntity: detailVocabEntity ?? this.detailVocabEntity,
        vocab: vocab ?? this.vocab,
        translation: translation ?? this.translation,
        typeVocabEntity: typeVocabEntity ?? this.typeVocabEntity,
        variation: variation ?? this.variation,
        note: note ?? this.note,
        isSuccess: isSuccess ?? this.isSuccess,
      );

  @override
  Exception? get errorState => exception;

  @override
  bool? get isLoading => statusLoading;
}
