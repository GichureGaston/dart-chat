import '../entities/chat_room.dart';

abstract class ChatRoomRepository {
  Future<void> createRoom(ChatRoomEntity room);
  Future<ChatRoomEntity?> getRoomById(String id);
  Future<List<ChatRoomEntity>> getAllRooms();
  Future<void> addUserToRoom(String roomId, String userId);
  Future<void> removeUserFromRoom(String roomId, String userId);
  Future<List<String>> getRoomMembers(String roomId);
}
