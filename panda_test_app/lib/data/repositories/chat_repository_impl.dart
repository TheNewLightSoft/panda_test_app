import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:panda_test_app/data/models/chat/message_model.dart';
import 'package:panda_test_app/domain/entities/message_entity.dart';
import 'package:panda_test_app/domain/repositories/chat_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatRepositoryImpl implements ChatRepository {
  late final WebSocketChannel channel;

  ChatRepositoryImpl() {
    _connect();
  }

  void _connect() {
    final webSocketUrl = Platform.isAndroid
        ? 'ws://10.0.2.2:3001/messages'
        : 'ws://localhost:3001/messages';
    channel = WebSocketChannel.connect(Uri.parse(webSocketUrl));
  }

  @override
  Stream<MessageEntity> receiveMessages() async* {
    try {
      await for (final message in channel.stream) {
        final decodedMessage = jsonDecode(message);
        final data = MessageModel.fromJson(decodedMessage);
        yield MessageEntity.fromModel(data);
      }
    } catch (e) {
      debugPrint('Error in WebSocket stream: $e');
    }
  }

  @override
  Future<void> sendMessage(String message) async {
    try {
      channel.sink.add(message);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  @override
  void dispose() {
    channel.sink.close();
  }
}
