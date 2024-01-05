import 'package:auth/src/domain/entities/login_entitiy.dart';
import 'package:common_dependency/common_dependency.dart';

abstract class AuthRepository {
  Future<Either<Exception, String>> login(LoginEntity body);
}