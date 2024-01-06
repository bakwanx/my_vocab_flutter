import 'package:auth/src/data/datasources/auth_data_source.dart';
import 'package:auth/src/data/repositories/auth_repository_impl.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:auth/src/domain/usecase/login_use_case.dart';
import 'package:auth/src/presentation/cubit/login_cubit.dart';
import 'package:common_dependency/common_dependency.dart';

class AuthModule {
  Future<void> call() async {

    di.registerLazySingleton<AuthDataSource>(
            () => AuthDataSourceImpl(dio: di()));
    di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authDataSource: di(),
      networkInfo: di(),
    ));
    di.registerLazySingleton(() =>(LoginUseCase(
      authRepository: di(),
    )));

  }
}