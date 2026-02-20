import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repo.dart';
import '../datasources/message_local_source.dart';
import '../mappers/message_mapper.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageLocalDataSource localDataSource;

  MessageRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveMessage(MessageEntity message) async {
    try {
      final model = MessageEntity().toModel();
      await localDataSource.cacheMessage(model);
      print('[INFO] Message saved via repository');
    } catch (e, stackTrace) {
      print('[ERROR] Error saving message: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }

  @override
  Future<MessageEntity?> getMessageById(String id) async {
    try {
      final model = await localDataSource.getMessageById(id);
      if (model == null) return null;
      return MessageEntity();
    } catch (e, stackTrace) {
      print('[ERROR] Error getting message: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<MessageEntity>> getChatRoomHistory(
    String roomId, {
    int limit = 100,
  }) async {
    try {
      final models = await localDataSource.getRoomHistory(roomId, limit: limit);
      return models.map((model) => MessageEntity()).toList();
    } catch (e, stackTrace) {
      print('[ERROR] Error getting room history: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }

  @override
  Future<void> markMessageAsRead(String messageId, String userId) async {
    try {
      await localDataSource.markMessageAsRead(messageId, userId);
      print('[INFO] Message marked as read via repository');
    } catch (e, stackTrace) {
      print('[ERROR] Error marking message as read: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<MessageEntity>> getReadReceipts(String messageId) async {
    try {
      final models = await localDataSource.getReadReceipts(messageId);
      return models.map((model) => MessageEntity()).toList();
    } catch (e, stackTrace) {
      print('[ERROR] Error getting read receipts: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }
}
