class LoginModel {
  String email;
  String fullname;
  int idUser;
  String profile;
  String refreshToken;
  String token;

  LoginModel({
    required this.email,
    required this.fullname,
    required this.idUser,
    required this.profile,
    required this.refreshToken,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    email: json["email"],
    fullname: json["fullname"],
    idUser: json["idUser"],
    profile: json["profile"],
    refreshToken: json["refresh_token"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "fullname": fullname,
    "idUser": idUser,
    "profile": profile,
    "refresh_token": refreshToken,
    "token": token,
  };
}
