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
    idType: json["IdType"],
    type: json["type"],
    description: json["description"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "IdType": idType,
    "type": type,
    "description": description,
    "CreatedAt": createdAt.toIso8601String(),
    "UpdatedAt": updatedAt.toIso8601String(),
  };
}
