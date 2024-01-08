import 'package:common_dependency/common_dependency.dart';
import 'package:home/src/data/datasources/home_data_source.dart';
import 'package:home/src/data/impl_repository/home_repository_impl.dart';
import 'package:home/src/domain/repository/home_repository.dart';
import 'package:home/src/domain/usecase/home_usecase.dart';

class HomeModule {
  Future<void> call() async {

    di.registerLazySingleton<HomeDataSource>(
            () => HomeDataSourceImpl(dio: di()));
    di.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
      homeDataSource: di(),
      networkInfo: di(),
      masterSharedPreferences: di(),
    ));
    di.registerLazySingleton(() =>(HomeUseCase(
      homeRepository: di(),
    )));

  }
}