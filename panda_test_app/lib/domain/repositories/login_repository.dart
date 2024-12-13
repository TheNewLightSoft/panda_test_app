import 'package:panda_test_app/domain/entities/user_session_entity.dart';

abstract class LoginRepository {
  Future<UserSessionEntity> login(String username, String password);
}
