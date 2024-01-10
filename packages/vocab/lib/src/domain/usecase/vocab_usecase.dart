import 'package:common_dependency/common_dependency.dart';
import 'package:vocab/src/data/models/dto/vocab_dto.dart';
import 'package:vocab/src/domain/entity/type_vocab_entity.dart';
import 'package:vocab/src/domain/repository/vocab_repository.dart';

import '../entity/vocab_entity.dart';

class VocabUseCase {
  final VocabRepository vocabRepository;

  VocabUseCase({required this.vocabRepository});

  Future<Either<Exception, List<TypeVocabEntity>>> getTypeVocabs() async {
    return vocabRepository.getTypeVocabs();
  }
  Future<Either<Exception, void>> postVocab({required VocabDto vocabDto}) async {
    return vocabRepository.postVocab(vocabDto: vocabDto);
  }
  Future<Either<Exception, VocabEntity>> getDetailVocab({required int idVocab}) async {
    return vocabRepository.getDetailVocab(idVocab: idVocab);
  }
}