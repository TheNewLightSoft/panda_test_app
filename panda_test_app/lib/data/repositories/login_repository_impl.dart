import 'package:dio/dio.dart';
import 'package:panda_test_app/data/models/login/login_request_model.dart';
import 'package:panda_test_app/data/models/login/login_response_model.dart';
import 'package:panda_test_app/domain/entities/user_session_entity.dart';
import 'package:panda_test_app/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final Dio dio;

  LoginRepositoryImpl(this.dio);

  @override
  Future<UserSessionEntity> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: LoginRequestModel(username: username, password: password).toJson(),
      );

      final responseData = LoginResponseModel.fromJson(response.data);
      return UserSessionEntity(
        isAuthenticated: responseData.success,
        token: responseData.token,
      );
    } catch (e) {
      if (e is DioException) {
        final errorData = e.response?.data;
        throw Exception(errorData?['message'] ?? 'Login failed');
      }
      throw Exception('Unexpected error');
    }
  }
}
