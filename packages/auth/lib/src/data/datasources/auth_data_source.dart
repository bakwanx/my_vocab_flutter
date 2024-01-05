import 'dart:convert';

import 'package:auth/src/domain/entities/login_entitiy.dart';
import 'package:common_dependency/common_dependency.dart';

abstract class AuthDataSource {
  Future<Either<Exception, String>> login(LoginEntity body);
}

class AuthDataSourceImpl implements AuthDataSource {
  final Dio dio;
  AuthDataSourceImpl({required this.dio});

  @override
  Future<Either<Exception, String>> login(LoginEntity body) async {
    try{
      final response = await dio.post(baseUrl + "/login", data: body.toJson());
      if(response.statusCode == 200){
        final statusCodeResponse = jsonEncode(response.data["code"]);
        final messageResponse = jsonEncode(response.data["message"]);

        return Right(messageResponse.toString());
      } else {
        final messageResponse = jsonEncode(response.data["message"]);
        return Left(ServerException(message: messageResponse));
      }
    }catch(e){
      return Left(ServerException());
    }
  }

}