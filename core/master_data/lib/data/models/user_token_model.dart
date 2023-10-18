class UserTokenModel {
  final String token;
  final String refreshToken;

  const UserTokenModel({required this.token, required this.refreshToken});

  factory UserTokenModel.fromJson(Map<String, dynamic> json) => UserTokenModel(
        token: json["token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refresh_token": refreshToken,
      };
}
