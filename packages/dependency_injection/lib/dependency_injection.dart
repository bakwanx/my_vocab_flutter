library dependency_injection;

import 'package:auth/auth_module.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:home/home_module.dart';
import 'package:vocab/vocab_module.dart';
export 'package:dependency_injection/dependency_injection.dart';

class DependencyInjector {
  Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final dio = Dio();
    di.registerLazySingleton(() => sharedPreferences);
    di.registerLazySingleton<Dio>(() => dio);
    di.registerLazySingleton(() => Connectivity());
    di.registerLazySingleton<MasterSharedPreferences>(
            () => MasterLocalImpl(sharedPreferences: di()));
    di.registerFactory(() => ApiInterceptor(dio, di()));
    dio.interceptors.addAll([
      ApiInterceptor(dio, di()),
    ]);
    di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));

    // package
    final authModule = AuthModule();
    final homeModule = HomeModule();
    final vocabModule = VocabModule();

    await authModule();
    await homeModule();
    await vocabModule();
  }
}
