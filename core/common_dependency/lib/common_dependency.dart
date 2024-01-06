import 'package:get_it/get_it.dart';

export 'package:shared_preferences/shared_preferences.dart';
export 'package:utils_app/error/exceptions.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:utils_app/common/common.dart';
export 'package:utils_app/extension/safe_null_object.dart';
export 'package:utils_app/error/error_extra.dart';
export 'package:master_data/data/data_sources/master_shared_preferences.dart';

export 'package:master_data/data/models/user_token_model.dart';
export 'package:master_data/presentation/base/my_vocab_screen.dart';
export 'package:master_data/presentation/base/my_vocab_listener.dart';
export 'package:master_data/presentation/base/my_vocab_state.dart';
export 'package:utils_app/const/asset_image.dart';
export 'package:utils_app/style/custom_style.dart';
export 'package:get_it/get_it.dart';
export 'package:master_data/master_data.dart';
export 'package:dependency_injection/dependency_injection.dart';
export 'package:common_dependency/common_dependency.dart';
export 'package:dio/dio.dart';
export 'package:utils_app/const/api_path.dart';
export 'package:service/api/dio_service.dart';
export 'package:service/api/api_interceptor.dart';
export 'package:dartz/dartz.dart' hide State;
export 'package:utils_app/common/usecase.dart';
export 'package:utils_app/network/network_info.dart';
export 'package:connectivity_plus/connectivity_plus.dart';


final di = GetIt.instance;
