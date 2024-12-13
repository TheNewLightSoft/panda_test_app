import 'package:get_it/get_it.dart';
import 'package:panda_test_app/core/client/dio_client.dart';
import 'package:panda_test_app/data/repositories/chat_repository_impl.dart';
import 'package:panda_test_app/data/repositories/login_repository_impl.dart';
import 'package:panda_test_app/domain/repositories/chat_repository.dart';
import 'package:panda_test_app/domain/repositories/login_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Register Dio client
  getIt.registerLazySingleton(() => DioClient());

  // Register LoginRepository
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt<DioClient>().dio),
  );

  // Register ChatRepository
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(),
  );
}
