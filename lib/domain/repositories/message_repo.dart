import '../entities/message.dart';

abstract class MessageRepository {
  Future<Either<Failure, void>> saveMessage(MessageEntity message);
  Future<Either<Failure, MessageEntity?>> getMessageById(String id);
  Future<Either<Failure, List<MessageEntity>>> getChatRoomHistory(
    String roomId, {
    int limit = 100,
  });
  Future<void> markMessageAsRead(String messageId, String userId);
}
