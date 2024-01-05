part of 'login_cubit.dart';


class LoginState implements MyVocabState {
  final Exception? exception;
  final bool statusLogin;
  final bool statusLoading;

  LoginState({
    required this.statusLogin,
    required this.statusLoading,
    required this.exception,
  });

  factory LoginState.initial() => LoginState(
        statusLogin: false,
    statusLoading: false,
        exception: null,
      );

  LoginState copyWith({
    bool? statusLogin,
    Exception? exception,
    bool? statusLoading,
  }) =>
      LoginState(
        statusLogin: statusLogin ?? this.statusLogin,
        statusLoading: statusLoading ?? this.statusLoading,
        exception: exception ?? this.exception,
      );

  @override
  Exception? get errorState => exception;

  @override
  bool? get isLoading => statusLoading;
}
