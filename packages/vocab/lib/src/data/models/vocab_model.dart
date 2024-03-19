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
    idVocab: json["id"],
    idUser: json["idUser"],
    idType: json["idType"],
    typeVocabModel: TypeVocabModel.fromJson(json["typeVocab"]),
    vocab: json["vocab"],
    translation: json["translation"],
    variation: json["variation"],
    note: json["note"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "idVocab": idVocab,
    "idUser": idUser,
    "idType": idType,
    "TypeVocab": typeVocabModel.toJson(),
    "vocab": vocab,
    "translation": translation,
    "variation": variation,
    "note": note,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

