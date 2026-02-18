// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MessageModel', json, ($checkedConvert) {
      final val = MessageModel(
        id: $checkedConvert('id', (v) => v as String?),
        userId: $checkedConvert('userId', (v) => v as String?),
        chatRoomId: $checkedConvert('chatRoomId', (v) => v as String?),
        text: $checkedConvert('text', (v) => v as String?),
        timeStamp: $checkedConvert('timeStamp', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'chatRoomId': instance.chatRoomId,
      'text': instance.text,
      'timeStamp': instance.timeStamp,
    };
