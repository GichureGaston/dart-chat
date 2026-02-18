import 'package:realtimechatapp/domain/entities/chat_room.dart';

import '../models/chat_room_model.dart';

extension ChatRoomModelMapper on ChatRoomModel {
  ChatRoomEntity toEntity() {
    return ChatRoomEntity(
      id: id,
      name: name,
      members: members,
      description: description,
      createdAt: createdAt,
    );
  }

  ChatRoomModel toModel() {
    return ChatRoomModel(
      id: id,
      name: name,
      members: members,
      description: description,
      createdAt: createdAt,
    );
  }
}
