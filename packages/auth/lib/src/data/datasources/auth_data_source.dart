import 'dart:convert';

import 'package:auth/src/domain/entities/login_entitiy.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';

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
      final messageResponse = jsonEncode(response.data["message"]);
      return Right(messageResponse.toString());
    } on DioException catch (e){
      return Left(DioException(requestOptions: e.requestOptions, response: e.response));
    } catch(e){
      return Left(ServerException(message: "Something when wrong"));
    }
  }

}