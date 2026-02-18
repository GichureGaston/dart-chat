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
  Future<void> cacheMessage(MessageModel message) {
    // TODO: implement cacheMessage
    throw UnimplementedError();
  }

  @override
  Future<MessageModel?> getMessageById(String id) {
    // TODO: implement getMessageById
    throw UnimplementedError();
  }

  @override
  Future<List<MessageModel>> getReadReceipts(String messageId) {
    // TODO: implement getReadReceipts
    throw UnimplementedError();
  }

  @override
  Future<List<MessageModel>> getRoomHistory(String roomId, {int limit = 100}) {
    // TODO: implement getRoomHistory
    throw UnimplementedError();
  }

  @override
  Future<void> markMessageAsRead(String messageId, String userId) {
    // TODO: implement markMessageAsRead
    throw UnimplementedError();
  }
}
