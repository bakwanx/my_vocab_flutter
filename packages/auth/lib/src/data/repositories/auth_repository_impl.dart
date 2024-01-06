import 'package:auth/src/data/datasources/auth_data_source.dart';
import 'package:auth/src/domain/entities/login_entitiy.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:common_dependency/common_dependency.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.authDataSource, required this.networkInfo});

  @override
  Future<Either<Exception, String>> login(LoginEntity body) async {
    if (await networkInfo.isConnected) {
      final _result = await authDataSource.login(body);
      return _result.fold((l) => Left(l), (r) => Right(r));
    } else {
      return Left(ServerException(message: "No connection"));
    }
  }
}
