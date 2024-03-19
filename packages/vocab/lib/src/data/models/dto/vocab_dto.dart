class VocabDto {
  int? idUser;
  int? idVocab;
  int idType;
  String translation;
  String vocab;
  String variation;
  String note;

  VocabDto({
    this.idUser,
    this.idVocab,
    required this.idType,
    required this.translation,
    required this.vocab,
    required this.variation,
    required this.note,
  });

  factory VocabDto.fromJson(Map<String, dynamic> json) => VocabDto(
    idUser: json["idUser"],
    idType: json["idType"],
    translation: json["translation"],
    vocab: json["vocab"],
    variation: json["variation"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "idType": idType,
    "translation": translation,
    "vocab": vocab,
    "variation": variation,
    "note": note,
  };
  Map<String, dynamic> toJsonForPatch() => {
    "idVocab": idVocab,
    "idType": idType,
    "translation": translation,
    "vocab": vocab,
    "variation": variation,
    "note": note,
  };
}