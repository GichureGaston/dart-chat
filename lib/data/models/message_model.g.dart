// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MessageModel', json, ($checkedConvert) {
  final val = MessageModel(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    chatRoomId: $checkedConvert('chatRoomId', (v) => v as String),
    text: $checkedConvert('text', (v) => v as String),
    timestamp: $checkedConvert('timestamp', (v) => DateTime.parse(v as String)),
    readBy: $checkedConvert(
      'readBy',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    ),
  );
  return val;
});

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'chatRoomId': instance.chatRoomId,
      'text': instance.text,
      'timestamp': instance.timestamp.toIso8601String(),
      'readBy': instance.readBy,
    };
