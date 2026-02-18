import '../models/chat_room_model.dart';

abstract class ChatRoomLocalDataSource {
  Future<void> createRoom(ChatRoomModel room);
  Future<ChatRoomModel?> getRoomById(String id);
  Future<List<ChatRoomModel>> getAllRooms();
  Future<void> addUserToRoom(String roomId, String userId);
  Future<void> removeUserFromRoom(String roomId, String userId);
  Future<List<String>> getRoomMembers(String roomId);
}

class ChatRoomLocalDataSourceImpl implements ChatRoomLocalDataSource {
  @override
  Future<void> addUserToRoom(String roomId, String userId) {
    // TODO: implement addUserToRoom
    throw UnimplementedError();
  }

  @override
  Future<void> createRoom(ChatRoomModel room) {
    // TODO: implement createRoom
    throw UnimplementedError();
  }

  @override
  Future<List<ChatRoomModel>> getAllRooms() {
    // TODO: implement getAllRooms
    throw UnimplementedError();
  }

  @override
  Future<ChatRoomModel?> getRoomById(String id) {
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
