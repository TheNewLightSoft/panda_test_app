import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panda_test_app/app/cubits/login/bloc.dart';
import 'package:panda_test_app/domain/repositories/login_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit(this.loginRepository) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
      final userSession = await loginRepository.login(username, password);
      emit(LoginSuccess(userSession));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
