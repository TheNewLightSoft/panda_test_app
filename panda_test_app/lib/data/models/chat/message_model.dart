import 'package:json_annotation/json_annotation.dart';
import 'package:panda_test_app/core/enums/message_type_enum.dart';

part 'message_model.g.dart';

@JsonSerializable(includeIfNull: true)
class MessageModel {
  final int id;
  final MessageTypeEnum type;
  final String sender;
  final String data;
  const MessageModel({
    required this.id,
    required this.data,
    required this.sender,
    required this.type,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
