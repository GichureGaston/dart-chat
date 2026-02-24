import '../models/message_model.dart';

abstract class MessageLocalDataSource {
  Future<void> cacheMessage(MessageModel message);
  Future<MessageModel?> getMessageById(String id);
  Future<List<MessageModel>> getRoomHistory(String roomId, {int limit = 100});
  Future<void> markMessageAsRead(String messageId, String userId);
  Future<List<MessageModel>> getReadReceipts(String messageId);
}

class MessageLocalDataSourceImpl implements MessageLocalDataSource {
  final Map<String, MessageModel> _messages = {};
  final Map<String, List<String>> _roomMessages = {};

  @override
  Future<void> cacheMessage(MessageModel message) async {
    if (message.id.isEmpty) throw ArgumentError('Message ID cannot be empty');
    if (message.chatRoomId.isEmpty) {
      throw ArgumentError('Room ID cannot be empty');
    }

    _messages[message.id] = message;
    _roomMessages.putIfAbsent(message.chatRoomId, () => []);
    if (!_roomMessages[message.chatRoomId]!.contains(message.id)) {
      _roomMessages[message.chatRoomId]!.add(message.id);
    }
  }

  @override
  Future<MessageModel?> getMessageById(String id) async {
    if (id.isEmpty) throw ArgumentError('Message ID cannot be empty');
    return _messages[id];
  }

  @override
  Future<List<MessageModel>> getRoomHistory(
    String roomId, {
    int limit = 100,
  }) async {
    if (roomId.isEmpty) throw ArgumentError('Room ID cannot be empty');

    final messageIds = _roomMessages[roomId] ?? [];
    if (messageIds.isEmpty) return [];

    final startIndex = (messageIds.length - limit).clamp(0, messageIds.length);
    return messageIds
        .sublist(startIndex)
        .map((id) => _messages[id])
        .whereType<MessageModel>()
        .toList();
  }

  @override
  Future<void> markMessageAsRead(String messageId, String userId) async {
    if (messageId.isEmpty) throw ArgumentError('Message ID cannot be empty');
    if (userId.isEmpty) throw ArgumentError('User ID cannot be empty');

    final message = _messages[messageId];
    if (message == null || message.readBy.contains(userId)) return;

    _messages[messageId] = message.copyWith(
      readBy: [...message.readBy, userId],
    );
  }

  @override
  Future<List<MessageModel>> getReadReceipts(String messageId) async {
    if (messageId.isEmpty) throw ArgumentError('Message ID cannot be empty');

    final message = _messages[messageId];
    return message != null ? [message] : [];
  }
}
