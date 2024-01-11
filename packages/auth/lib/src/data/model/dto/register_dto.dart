import 'package:common_dependency/common_dependency.dart';

class RegisterDto {
  String email;
  String password;
  String fullname;
  MultipartFile photoProfile;

  RegisterDto(
      {required this.email,
      required this.password,
      required this.fullname,
      required this.photoProfile,});

  FormData toFormData() => FormData.fromMap({
        "email": email,
        "password": password,
        "fullname": fullname,
        "profile": photoProfile,
      });
}
