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
  final Map<String, ChatRoomModel> _rooms = {};

  @override
  Future<void> createRoom(ChatRoomModel room) async {
    if (room.id.isEmpty) throw ArgumentError('Room ID cannot be empty');
    if (room.name.isEmpty) throw ArgumentError('Room name cannot be empty');
    _rooms[room.id] = room;
  }

  @override
  Future<ChatRoomModel?> getRoomById(String id) async {
    if (id.isEmpty) throw ArgumentError('Room ID cannot be empty');
    return _rooms[id];
  }

  @override
  Future<List<ChatRoomModel>> getAllRooms() async {
    return _rooms.values.toList();
  }

  @override
  Future<void> addUserToRoom(String roomId, String userId) async {
    if (roomId.isEmpty) throw ArgumentError('Room ID cannot be empty');
    if (userId.isEmpty) throw ArgumentError('User ID cannot be empty');

    final room = _rooms[roomId];
    if (room == null) throw ArgumentError('Room not found: $roomId');
    if (room.members.contains(userId)) return;

    _rooms[roomId] = room.copyWith(members: [...room.members, userId]);
  }

  @override
  Future<void> removeUserFromRoom(String roomId, String userId) async {
    if (roomId.isEmpty) throw ArgumentError('Room ID cannot be empty');
    if (userId.isEmpty) throw ArgumentError('User ID cannot be empty');

    final room = _rooms[roomId];
    if (room == null) throw ArgumentError('Room not found: $roomId');

    _rooms[roomId] = room.copyWith(
      members: room.members.where((id) => id != userId).toList(),
    );
  }

  @override
  Future<List<String>> getRoomMembers(String roomId) async {
    if (roomId.isEmpty) throw ArgumentError('Room ID cannot be empty');
    return _rooms[roomId]?.members ?? [];
  }
}
