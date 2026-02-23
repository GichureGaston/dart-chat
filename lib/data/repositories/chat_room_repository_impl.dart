import 'package:realtimechatapp/domain/entities/chat_room.dart';
import 'package:realtimechatapp/domain/repositories/chat_room_repo.dart';

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  @override
  Future<void> addUserToRoom(String roomId, String userId) {
    // TODO: implement addUserToRoom
    throw UnimplementedError();
  }

  @override
  Future<void> createRoom(ChatRoomEntity room) {
    // TODO: implement createRoom
    throw UnimplementedError();
  }

  @override
  Future<List<ChatRoomEntity>> getAllRooms() {
    // TODO: implement getAllRooms
    throw UnimplementedError();
  }

  @override
  Future<ChatRoomEntity?> getRoomById(String id) {
    // TODO: implement getRoomById
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getRoomMembers(String roomId) {
    // TODO: implement getRoomMembers
    throw UnimplementedError();
  }

  @override
  Future<void> removeUserFromRoom(String roomId, String userId) {
    // TODO: implement removeUserFromRoom
    throw UnimplementedError();
  }
}
