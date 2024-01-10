import 'package:vocab/src/domain/entity/type_vocab_entity.dart';

class VocabEntity {
  int idVocab;
  int idUser;
  int idType;
  TypeVocabEntity typeVocab;
  String vocab;
  String translation;
  String variation;
  String note;
  DateTime createdAt;
  DateTime updatedAt;

  VocabEntity({
    required this.idVocab,
    required this.idUser,
    required this.idType,
    required this.typeVocab,
    required this.vocab,
    required this.translation,
    required this.variation,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

}
