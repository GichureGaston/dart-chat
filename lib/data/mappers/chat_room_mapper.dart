import 'package:realtimechatapp/data/models/chat_room_model.dart';
import 'package:realtimechatapp/domain/entities/chat_room.dart';

class ChatRoomMapper {
  static ChatRoomModel toModel(ChatRoomEntity entity) {
    return ChatRoomModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      members: entity.members.toList(),
      createdAt: entity.createdAt,
    );
  }

  static ChatRoomEntity toEntity(ChatRoomModel model) {
    return ChatRoomEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      members: model.members.toSet(),
      createdAt: model.createdAt,
    );
  }
}
