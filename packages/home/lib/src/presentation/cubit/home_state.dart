
import 'package:common_dependency/common_dependency.dart';
import 'package:home/src/domain/entities/vocab_entity.dart';

class HomeState implements MyVocabState {
  final Exception? exception;
  final bool statusLoading;
  final bool isLogOut;
  final List<VocabEntity> vocabEntities;
  HomeState({
    required this.statusLoading,
    required this.exception,
    required this.isLogOut,
    required this.vocabEntities,
  });

  factory HomeState.initial() => HomeState(
    statusLoading: false,
    exception: null,
    vocabEntities: [],
    isLogOut: false,
  );

  HomeState copyWith({
    Exception? exception,
    bool? statusLoading,
    bool? isLogOut,
    List<VocabEntity>? vocabEntities,
  }) =>
      HomeState(
        statusLoading: statusLoading ?? this.statusLoading,
        exception: exception ?? this.exception,
        vocabEntities: vocabEntities ?? this.vocabEntities,
          isLogOut: isLogOut ?? this.isLogOut,
      );

  @override
  Exception? get errorState => exception;

  @override
  bool? get isLoading => statusLoading;
}