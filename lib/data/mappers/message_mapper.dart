import '../../domain/entities/message.dart';
import '../models/message_model.dart';

class MessageMapper {
  static MessageModel toModel(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      userId: entity.userId,
      chatRoomId: entity.chatRoomId,
      text: entity.text,
      timestamp: entity.timestamp,
    );
  }

  static MessageEntity toEntity(MessageModel model) {
    return MessageEntity(
      id: model.id,
      userId: model.userId,
      chatRoomId: model.chatRoomId,
      text: model.text,
      timestamp: model.timestamp,
    );
  }
}
