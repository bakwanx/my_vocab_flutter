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

class TypeVocabEntity {
  int idType;
  String type;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  TypeVocabEntity({
    required this.idType,
    required this.type,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

}