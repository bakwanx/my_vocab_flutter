import 'package:common_dependency/common_dependency.dart';

class SplashState implements MyVocabState {
  final Exception? exception;
  final bool isLogin;
  final bool statusLoading;

  SplashState({
    required this.exception,
    required this.isLogin,
    required this.statusLoading,
  });

  factory SplashState.initial() => SplashState(
    isLogin: false,
    statusLoading: false,
    exception: null,
  );

  SplashState copyWith({
    bool? statusLogin,
    Exception? exception,
    bool? statusLoading,
  }) =>
      SplashState(
        isLogin: statusLogin ?? this.isLogin,
        statusLoading: statusLoading ?? this.statusLoading,
        exception: exception ?? this.exception,
      );


  @override
  // TODO: implement errorState
  Exception? get errorState => exception;

  @override
  // TODO: implement isLoading
  bool? get isLoading => statusLoading;
}
