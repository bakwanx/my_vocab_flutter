class UserLocalModel {
  int idUser;
  String email;
  String fullname;

  UserLocalModel({
    required this.idUser,
    required this.email,
    required this.fullname,
  });

  factory UserLocalModel.fromJson(Map<String, dynamic> json) => UserLocalModel(
    idUser: json["idUser"],
    email: json["email"],
    fullname: json["fullname"],
  );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "email": email,
    "fullname": fullname,
  };
}
