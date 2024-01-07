import 'package:common_dependency/common_dependency.dart';
import 'package:home/src/domain/entities/vocab_entity.dart';

abstract class HomeRepository {
  Future<Either<Exception, List<VocabEntity>>> getVocabs();
}