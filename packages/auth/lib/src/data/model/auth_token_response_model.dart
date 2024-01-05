class AuthTokenResponseModel {
  String refreshToken;
  String token;

  AuthTokenResponseModel({
    required this.refreshToken,
    required this.token,
  });

  factory AuthTokenResponseModel.fromJson(Map<String, dynamic> json) => AuthTokenResponseModel(
    refreshToken: json["refresh_token"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "refresh_token": refreshToken,
    "token": token,
  };
}
