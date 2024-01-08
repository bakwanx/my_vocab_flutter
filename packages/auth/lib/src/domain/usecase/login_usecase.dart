import 'package:auth/src/domain/entities/login_entitiy.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<Unit> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Exception, dynamic>> call(Map<String, dynamic> data,
      {Map<String, dynamic>? option}) async {

    final service = await authRepository.login(
      LoginEntity(
        data["email"].toString().toLowerCase(),
        data["password"],
      ),
    );

    return service.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
