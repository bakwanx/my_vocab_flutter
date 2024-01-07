import 'package:auth/src/domain/entities/login_entitiy.dart';
import 'package:common_dependency/common_dependency.dart';

import '../../data/model/login_model.dart';

abstract class AuthRepository {
  Future<Either<Exception, LoginModel>> login(LoginEntity body);
}