import 'package:dartz/dartz.dart';
import 'package:realtimechatapp/core/errors/failures.dart';

import '../entities/chat_room.dart';

abstract class ChatRoomRepository {
  Future<Either<Failure, void>> createRoom(ChatRoomEntity room);
  Future<Either<Failure, ChatRoomEntity?>> getRoomById(String id);
  Future<Either<Failure, List<ChatRoomEntity>>> getAllRooms();
  Future<Either<Failure, void>> addUserToRoom(String roomId, String userId);
  Future<Either<Failure, void>> removeUserFromRoom(
    String roomId,
    String userId,
  );
  Future<Either<Failure, List<String>>> getRoomMembers(String roomId);
}
