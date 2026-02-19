import '../models/message_model.dart';

abstract class MessageLocalDataSource {
  Future<void> cacheMessage(MessageModel message);
  Future<MessageModel?> getMessageById(String id);
  Future<List<MessageModel>> getRoomHistory(String roomId, {int limit = 100});
  Future<void> markMessageAsRead(String messageId, String userId);
  Future<List<MessageModel>> getReadReceipts(String messageId);
}

class MessageLocalDataSourceImpl implements MessageLocalDataSource {
  final Map<String, MessageModel> messages = {};
  final Map<String, List<String>> roomMessages = {};

  @override
  Future<void> cacheMessage(MessageModel message) async {
    try {
      if (message.id.isEmpty) {
        throw ArgumentError('Message ID Cannot be empty');
      }
      if (message.chatRoomId.isEmpty) {
        throw ArgumentError('ChatRoom ID cannot be empty');
      }
      messages[message.id] = message;
      roomMessages.putIfAbsent(message.chatRoomId, () => []);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessageModel?> getMessageById(String id) async {
    // TODO: implement getMessageById
    throw UnimplementedError();
  }

  @override
  Future<List<MessageModel>> getReadReceipts(String messageId) async {
    // TODO: implement getReadReceipts
    throw UnimplementedError();
  }

  @override
  Future<List<MessageModel>> getRoomHistory(
    String roomId, {
    int limit = 100,
  }) async {
    // TODO: implement getRoomHistory
    throw UnimplementedError();
  }

  @override
  Future<void> markMessageAsRead(String messageId, String userId) async {
    // TODO: implement markMessageAsRead
    try {} catch (e) {
      rethrow;
    }
  }
}
