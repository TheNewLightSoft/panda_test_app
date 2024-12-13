import 'package:panda_test_app/domain/entities/message_entity.dart';

abstract class ChatRepository {
  /// Получить поток сообщений в реальном времени из WebSocket
  Stream<MessageEntity> receiveMessages();
  Future<void> sendMessage(String message);
  void dispose();
}
