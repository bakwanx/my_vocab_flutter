import 'package:auth/src/data/datasources/auth_data_source.dart';
import 'package:auth/src/data/model/login_model.dart';
import 'package:auth/src/domain/entities/login_entitiy.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:common_dependency/common_dependency.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final NetworkInfo networkInfo;
  final MasterSharedPreferences masterSharedPreferences;
  AuthRepositoryImpl(
      {required this.authDataSource, required this.networkInfo, required this.masterSharedPreferences});

  @override
  Future<Either<Exception, LoginModel>> login(LoginEntity body) async {
    if (await networkInfo.isConnected) {
      final _result = await authDataSource.login(body);

      return _result.fold((l) => Left(l), (r) {
        masterSharedPreferences.setUserTokenModel(
          UserTokenModel(
            token: r.token,
            refreshToken: r.refreshToken,
          ),
        );
        masterSharedPreferences.setUserData(
          UserLocalModel(
            idUser: r.idUser,
            email: r.email,
            fullname: r.fullname,
          ),
        );
        masterSharedPreferences.setStatusLogin();
        return Right(r);
      });
    } else {
      return Left(ServerException(message: "No connection"));
    }
  }
}
