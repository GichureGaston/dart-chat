import 'package:dartz/dartz.dart';
import 'package:realtimechatapp/core/errors/failures.dart';

import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repo.dart';
import '../datasources/message_local_source.dart';
import '../mappers/message_mapper.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageLocalDataSource localDataSource;

  MessageRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> saveMessage(MessageEntity message) async {
    try {
      final model = MessageMapper.toModel(message);
      await localDataSource.cacheMessage(model);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageEntity?>> getMessageById(String id) async {
    try {
      final model = await localDataSource.getMessageById(id);
      if (model == null) return const Right(null);
      return Right(MessageMapper.toEntity(model));
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getChatRoomHistory(
    String roomId, {
    int limit = 100,
  }) async {
    try {
      final models = await localDataSource.getRoomHistory(roomId, limit: limit);
      return Right(models.map(MessageMapper.toEntity).toList());
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markMessageAsRead(
    String messageId,
    String userId,
  ) async {
    try {
      await localDataSource.markMessageAsRead(messageId, userId);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getReadReceipts(
    String messageId,
  ) async {
    try {
      final models = await localDataSource.getReadReceipts(messageId);
      return Right(models.map(MessageMapper.toEntity).toList());
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }
}
