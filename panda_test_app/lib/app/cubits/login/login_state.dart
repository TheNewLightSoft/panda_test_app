import 'package:panda_test_app/domain/entities/user_session_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserSessionEntity userSession;

  LoginSuccess(this.userSession);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
