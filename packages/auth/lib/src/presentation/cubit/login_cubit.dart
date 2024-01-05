import 'package:auth/src/domain/usecase/login_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with MyVocabListener {
  final LoginUseCase loginUseCase;

  LoginCubit({
    required this.loginUseCase,
  }) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(statusLoading: true));
    final result = await loginUseCase.call({
      "email": email,
      "password": password
    });
    result.fold((l) {
      emit(state.copyWith());
    }, (r) => null);
  }

  @override
  clearErrorState() {
    emit((state).copyWith(
      exception: null,
      statusLoading: false,
    ));
  }
}
