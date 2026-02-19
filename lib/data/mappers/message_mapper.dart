import 'package:realtimechatapp/data/models/message_model.dart';
import 'package:realtimechatapp/domain/entities/message.dart';

extension MessageEntityMapper on MessageEntity {
  MessageModel toModel() {
    return MessageModel(
      id: '',
      userId: userId,
      chatRoomId: '',
      text: text,
      timeStamp: timeStamp,
    );
  }
}

extension MessageModelMapper on MessageModel {
  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      userId: userId,
      chatRoomId: chatRoomId,
      text: text,
      timeStamp: timeStamp,
    );
  }
}
