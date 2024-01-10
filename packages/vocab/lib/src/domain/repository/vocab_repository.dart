import 'package:common_dependency/common_dependency.dart';
import 'package:vocab/src/domain/entity/type_vocab_entity.dart';

import '../../data/models/dto/vocab_dto.dart';
import '../entity/vocab_entity.dart';

abstract class VocabRepository {
  Future<Either<Exception, List<TypeVocabEntity>>> getTypeVocabs();
  Future<Either<Exception, void>> postVocab({required VocabDto vocabDto});
  Future<Either<Exception, VocabEntity>> getDetailVocab({required int idVocab});
}