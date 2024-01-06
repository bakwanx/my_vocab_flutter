import 'dart:convert';

import 'package:common_dependency/common_dependency.dart';
import 'package:master_data/data/models/user_token_model.dart';

abstract class MasterSharedPreferences {
  Future<UserTokenModel?> getUserTokenModel();
  Future<void> setUserTokenModel(UserTokenModel userTokenModel);
}

const JWT_TOKEN_KEY = "JWT_TOKEN_KEY";

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


}