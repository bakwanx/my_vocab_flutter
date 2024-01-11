import 'package:auth/src/data/model/dto/register_dto.dart';
import 'package:auth/src/domain/entities/login_entitiy.dart';
import 'package:common_dependency/common_dependency.dart';

import '../../data/model/login_model.dart';

abstract class AuthRepository {
  Future<Either<Exception, LoginModel>> login(LoginEntity body);
  Future<Either<Exception, void>> register(RegisterDto registerDto);
}