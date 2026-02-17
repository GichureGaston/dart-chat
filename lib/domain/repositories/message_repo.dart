import '../entities/message.dart';

abstract class MessageRepository {
  Future<void> saveMessage(MessageEntity message);
  Future<MessageEntity?> getMessageById(String id);
  Future<List<MessageEntity>> getChatRoomHistory(
    String roomId, {
    int limit = 100,
  });
  Future<void> markMessageAsRead(String messageId, String userId);
}
