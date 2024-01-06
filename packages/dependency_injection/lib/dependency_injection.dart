library dependency_injection;

import 'package:auth/auth_module.dart';
import 'package:common_dependency/common_dependency.dart';
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
      ApiInterceptor(di(), di()),
    ]);
    di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));

    // package
    final authModule = AuthModule();

    await authModule();
  }
}
