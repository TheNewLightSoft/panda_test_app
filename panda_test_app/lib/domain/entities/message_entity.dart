import 'package:panda_test_app/core/enums/message_type_enum.dart';
import 'package:panda_test_app/data/models/chat/message_model.dart';

class MessageEntity {
  final int id;
  final int? tempId;
  final MessageTypeEnum type;
  final String sender;
  final String data;
  const MessageEntity({
    required this.id,
    this.tempId,
    required this.data,
    required this.sender,
    required this.type,
  });

  factory MessageEntity.fromModel(MessageModel model) {
    return MessageEntity(
      id: model.id,
      data: model.data,
      sender: model.sender,
      type: model.type,
    );
  }
}
