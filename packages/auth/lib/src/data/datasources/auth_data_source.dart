
import 'package:auth/src/data/model/login_model.dart';
import 'package:auth/src/domain/entities/login_entitiy.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';

import '../model/dto/register_dto.dart';

abstract class AuthDataSource {
  Future<Either<Exception, LoginModel>> login(LoginEntity body);
  Future<Either<Exception, void>> register(RegisterDto registerDto);
}

class AuthDataSourceImpl implements AuthDataSource {
  final Dio dio;
  AuthDataSourceImpl({required this.dio});

  @override
  Future<Either<Exception, LoginModel>> login(LoginEntity body) async {
    try{
      final response = await dio.post(baseUrl + "/login", data: body.toJson());
      return Right(LoginModel.fromJson(response.data["data"]));
    } on DioException catch (e){
      return Left(DioException(requestOptions: e.requestOptions, response: e.response));
    } catch(e){
      return Left(ServerException(message: "Something when wrong"));
    }
  }

  @override
  Future<Either<Exception, void>> register(RegisterDto registerDto) async {
    try{
      final response = await dio.post(baseUrl + "/register", data: registerDto.toFormData());
      return Right(LoginModel.fromJson(response.data["message"]));
    } on DioException catch (e){
      return Left(DioException(requestOptions: e.requestOptions, response: e.response));
    } catch(e){
      return Left(ServerException(message: "Something when wrong"));
    }
  }

}