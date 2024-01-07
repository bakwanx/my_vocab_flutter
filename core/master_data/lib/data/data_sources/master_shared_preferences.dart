import 'dart:convert';

import 'package:common_dependency/common_dependency.dart';
import 'package:master_data/data/models/user_token_model.dart';

abstract class MasterSharedPreferences {
  Future<UserTokenModel?> getUserTokenModel();
  Future<void> setUserTokenModel(UserTokenModel userTokenModel);
  Future<UserLocalModel> getUserLocalModel();
  Future<void> setUserData(UserLocalModel userLocalModel);
  Future<bool> getStatusLogin();
  Future<void> setStatusLogin();
}

const JWT_TOKEN_KEY = "JWT_TOKEN_KEY";
const USER_DATA_KEY = "USER_DATA_KEY";
const STATUS_LOGIN_KEY = "STATUS_LOGIN_KEY";

class MasterLocalImpl extends MasterSharedPreferences {
  // SharedPreferences sharedPreferences;
  final SharedPreferences sharedPreferences;
  MasterLocalImpl({required this.sharedPreferences});

  @override
  Future<UserTokenModel?> getUserTokenModel() async {
    final jsonString = sharedPreferences.getString(JWT_TOKEN_KEY);
    if(jsonString != null){
      return Future.value(UserTokenModel.fromJson(jsonDecode(jsonString)));
    }
    return null;
  }

  @override
  Future<void> setUserTokenModel(UserTokenModel userTokenModel) {
    return sharedPreferences.setString(JWT_TOKEN_KEY, jsonEncode(userTokenModel.toJson()));
  }

  @override
  Future<UserLocalModel> getUserLocalModel() async {
    final jsonString = await sharedPreferences.getString(USER_DATA_KEY);
    return UserLocalModel.fromJson(
      jsonDecode(jsonString!),
    );
  }

  @override
  Future<void> setUserData(UserLocalModel userLocalModel) {
    return sharedPreferences.setString(
      USER_DATA_KEY,
      jsonEncode(
        userLocalModel.toJson(),
      ),
    );
  }

  @override
  Future<bool> getStatusLogin() async {
    final result = await sharedPreferences.getBool(STATUS_LOGIN_KEY);
    if (result != null) {
      return true;
    }
    return false;
  }

  @override
  Future<void> setStatusLogin() {
    return sharedPreferences.setBool(STATUS_LOGIN_KEY, true);
  }


}