import 'package:common_dependency/common_dependency.dart';
import 'package:service/api/api_interceptor.dart';

class DioService {
  final MasterSharedPreferences masterSharedPreferences;
  final Dio dio;
  DioService(this.masterSharedPreferences, this.dio) {
    addInterceptor(ApiInterceptor(dio, masterSharedPreferences));
  }

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}