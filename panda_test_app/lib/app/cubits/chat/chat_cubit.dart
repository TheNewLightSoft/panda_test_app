import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panda_test_app/app/cubits/chat/bloc.dart';
import 'package:panda_test_app/core/enums/message_type_enum.dart';
import 'package:panda_test_app/domain/entities/message_entity.dart';
import 'package:panda_test_app/domain/repositories/chat_repository.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;
  late final Stream<MessageEntity> _messageStream;

  ChatCubit(this.chatRepository) : super(ChatInitial()) {
    _subscribeToMessages();
  }

  void _subscribeToMessages() {
    emit(ChatLoading());
    try {
      _messageStream = chatRepository.receiveMessages();
      _messageStream.listen(_handleIncomingMessage);
    } catch (e) {
      _emitError('Error subscribing to messages: $e');
    } finally {
      emit(ChatLoaded([]));
    }
  }

  void _handleIncomingMessage(MessageEntity message) {
    debugPrint('📩 Received message from server: $message');
    if (message.type == MessageTypeEnum.status) {
      _handleTypingStatus(message);
    } else if (message.type == MessageTypeEnum.message) {
      _handleNewMessage(message);
    }
  }

  void _handleTypingStatus(MessageEntity message) {
    debugPrint('ℹ️ Handling typing status: $message');
    if (state is! ChatLoaded) {
      emit(ChatLoaded([message]));
      return;
    }

    final currentMessages = List<MessageEntity>.from((state as ChatLoaded).messages);
    if (message.data == 'Typing stopped') {
      currentMessages.removeWhere((msg) => msg.type == MessageTypeEnum.status);
    } else {
      final index =
          currentMessages.indexWhere((msg) => msg.type == MessageTypeEnum.status);
      if (index == -1) {
        currentMessages.insert(0, message);
      } else {
        currentMessages[index] = message;
      }
    }

    emit(ChatLoaded(currentMessages));
  }

  void _handleNewMessage(MessageEntity message) {
    debugPrint('ℹ️ Handling new message: $message');
    if (state is! ChatLoaded) {
      emit(ChatLoaded([message]));
      return;
    }

    final currentMessages = List<MessageEntity>.from((state as ChatLoaded).messages);
    currentMessages.removeWhere((msg) => msg.type == MessageTypeEnum.status);
    currentMessages.insert(0, message);

    emit(ChatLoaded(currentMessages));
  }

  Future<void> sendMessage(String message) async {
    final tempId = DateTime.now().millisecondsSinceEpoch;

    final localMessage = MessageEntity(
      id: tempId,
      tempId: tempId,
      type: MessageTypeEnum.message,
      sender: 'me',
      data: message,
    );

    _addLocalMessage(localMessage);

    try {
      final jsonMessage = jsonEncode({'type': 'message', 'data': message});
      debugPrint('📤 Sending message to server: $jsonMessage');
      await chatRepository.sendMessage(jsonMessage);
    } catch (e) {
      _emitError('Error sending message: $e');
    }
  }

  void _addLocalMessage(MessageEntity message) {
    if (state is! ChatLoaded) {
      emit(ChatLoaded([message]));
      return;
    }

    final currentMessages = List<MessageEntity>.from((state as ChatLoaded).messages);
    currentMessages.insert(0, message);
    emit(ChatLoaded(currentMessages));
  }

  void _emitError(String error) {
    debugPrint('❌ $error');
    emit(ChatError(error));
  }

  void dispose() {
    debugPrint('🛑 Disposing ChatCubit');
    chatRepository.dispose();
  }
}
