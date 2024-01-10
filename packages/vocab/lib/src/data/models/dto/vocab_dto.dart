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
    idUser: json["id_user"],
    idType: json["id_type"],
    translation: json["translation"],
    vocab: json["vocab"],
    variation: json["variation"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "id_type": idType,
    "translation": translation,
    "vocab": vocab,
    "variation": variation,
    "note": note,
  };
  Map<String, dynamic> toJsonForPatch() => {
    "id_vocab": idVocab,
    "id_type": idType,
    "translation": translation,
    "vocab": vocab,
    "variation": variation,
    "note": note,
  };
}