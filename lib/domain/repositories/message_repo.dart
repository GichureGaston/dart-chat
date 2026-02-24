import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/message.dart';

abstract class MessageRepository {
  Future<Either<Failure, void>> saveMessage(MessageEntity message);
  Future<Either<Failure, MessageEntity?>> getMessageById(String id);
  Future<Either<Failure, List<MessageEntity>>> getChatRoomHistory(
    String roomId, {
    int limit = 100,
  });
  Future<Either<Failure, void>> markMessageAsRead(
    String messageId,
    String userId,
  );
  Future<Either<Failure, List<MessageEntity>>> getReadReceipts(
    String messageId,
  );
}
