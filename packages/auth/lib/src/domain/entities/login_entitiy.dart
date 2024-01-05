class LoginEntity {
  String email;
  String password;
  LoginEntity(this.email, this.password);

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password
  };

}