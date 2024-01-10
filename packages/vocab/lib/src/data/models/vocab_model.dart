import 'package:vocab/src/data/models/type_vocab_model.dart';
import 'package:vocab/src/domain/entity/vocab_entity.dart';

class VocabModel extends VocabEntity {
  int idVocab;
  int idUser;
  int idType;
  TypeVocabModel typeVocabModel;
  String vocab;
  String translation;
  String variation;
  String note;
  DateTime createdAt;
  DateTime updatedAt;

  VocabModel({
    required this.idVocab,
    required this.idUser,
    required this.idType,
    required this.typeVocabModel,
    required this.vocab,
    required this.translation,
    required this.variation,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
    idVocab: idVocab,
    idUser: idUser,
    idType: idType,
    typeVocab: typeVocabModel,
    vocab: vocab,
    translation: translation,
    variation: variation,
    note: note,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory VocabModel.fromJson(Map<String, dynamic> json) => VocabModel(
    idVocab: json["id_vocab"],
    idUser: json["id_user"],
    idType: json["id_type"],
    typeVocabModel: TypeVocabModel.fromJson(json["TypeVocab"]),
    vocab: json["vocab"],
    translation: json["translation"],
    variation: json["variation"],
    note: json["note"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id_vocab": idVocab,
    "id_user": idUser,
    "id_type": idType,
    "TypeVocab": typeVocabModel.toJson(),
    "vocab": vocab,
    "translation": translation,
    "variation": variation,
    "note": note,
    "CreatedAt": createdAt.toIso8601String(),
    "UpdatedAt": updatedAt.toIso8601String(),
  };
}

