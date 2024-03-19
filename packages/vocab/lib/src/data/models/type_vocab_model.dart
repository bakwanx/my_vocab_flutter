import 'package:vocab/src/domain/entity/type_vocab_entity.dart';

class TypeVocabModel extends TypeVocabEntity{
  int idType;
  String type;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  TypeVocabModel({
    required this.idType,
    required this.type,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  }): super(
    idType: idType,
    type: type,
    description: description,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory TypeVocabModel.fromJson(Map<String, dynamic> json) => TypeVocabModel(
    idType: json["id"],
    type: json["type"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": idType,
    "type": type,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
