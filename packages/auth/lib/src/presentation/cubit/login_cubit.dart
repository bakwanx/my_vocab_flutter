import 'package:auth/src/domain/usecase/login_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with MyVocabListener {
  final LoginUseCase _loginUseCase;

  LoginCubit({
    required LoginUseCase loginUseCase,
  }) : _loginUseCase = loginUseCase, super(LoginState.initial());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(statusLoading: true));
    final result = await _loginUseCase.call({
      "email": email,
      "password": password
    });
    result.fold((l) {
      emit(state.copyWith(
        statusLoading: false,
        exception: l,
      ));
    }, (r) {
      emit(state.copyWith(
        statusLoading: false,
        statusLogin: true,
      ));
    });
  }

  @override
  clearErrorState() {
    emit((state).copyWith(
      exception: null,
      statusLoading: false,
    ));
  }
}
