import 'package:dartz/dartz.dart';
import 'package:realtimechatapp/core/errors/failures.dart';
import 'package:realtimechatapp/data/datasources/chat_room_source.dart';
import 'package:realtimechatapp/data/mappers/chat_room_mapper.dart';
import 'package:realtimechatapp/domain/entities/chat_room.dart';
import 'package:realtimechatapp/domain/repositories/chat_room_repo.dart';

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final ChatRoomLocalDataSource localDataSource;

  ChatRoomRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> createRoom(ChatRoomEntity room) async {
    try {
      final model = ChatRoomMapper.toModel(room);
      await localDataSource.createRoom(model);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatRoomEntity?>> getRoomById(String id) async {
    try {
      final model = await localDataSource.getRoomById(id);
      if (model == null) return const Right(null);
      return Right(ChatRoomMapper.toEntity(model));
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatRoomEntity>>> getAllRooms() async {
    try {
      final models = await localDataSource.getAllRooms();
      return Right(models.map(ChatRoomMapper.toEntity).toList());
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addUserToRoom(
    String roomId,
    String userId,
  ) async {
    try {
      await localDataSource.addUserToRoom(roomId, userId);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeUserFromRoom(
    String roomId,
    String userId,
  ) async {
    try {
      await localDataSource.removeUserFromRoom(roomId, userId);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRoomMembers(String roomId) async {
    try {
      final members = await localDataSource.getRoomMembers(roomId);
      return Right(members);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }
}
