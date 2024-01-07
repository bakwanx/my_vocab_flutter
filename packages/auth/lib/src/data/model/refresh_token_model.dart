class RefreshTokenModel {
  String refreshToken;
  String token;

  RefreshTokenModel({
    required this.refreshToken,
    required this.token,
  });

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => RefreshTokenModel(
    refreshToken: json["refresh_token"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "refresh_token": refreshToken,
    "token": token,
  };
}
