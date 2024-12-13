// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: (json['id'] as num).toInt(),
      data: json['data'] as String,
      sender: json['sender'] as String,
      type: $enumDecode(_$MessageTypeEnumEnumMap, json['type']),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumEnumMap[instance.type]!,
      'sender': instance.sender,
      'data': instance.data,
    };

const _$MessageTypeEnumEnumMap = {
  MessageTypeEnum.status: 'status',
  MessageTypeEnum.message: 'message',
};
