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
    try {
      if (message.id.isEmpty) {
        throw ArgumentError('Message ID cannot be empty');
      }
      if (message.chatRoomId.isEmpty) {
        throw ArgumentError('Room ID cannot be empty');
      }

      _messages[message.id] = message;
      _roomMessages.putIfAbsent(message.chatRoomId, () => []);
      if (!_roomMessages[message.chatRoomId]!.contains(message.id)) {
        _roomMessages[message.chatRoomId]!.add(message.id);
      }

      // Print message details
      print('\n═══════════════════════════════════════');
      print('[MESSAGE STORED]');
      print('  ID: ${message.id}');
      print('  User: ${message.userId}');
      print('  Room: ${message.chatRoomId}');
      print('  Text: ${message.text}');
      print('  Timestamp: ${message.timestamp}');
      print('═══════════════════════════════════════\n');
    } catch (e, stackTrace) {
      print('[ERROR] Error caching message: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }

  @override
  Future<MessageModel?> getMessageById(String id) async {
    try {
      if (id.isEmpty) {
        throw ArgumentError('Message ID cannot be empty');
      }
      final message = _messages[id];
      if (message != null) {
        print('[INFO] Retrieved message: $id');
      } else {
        print('[WARNING] Message not found: $id');
      }
      return message;
    } catch (e, stackTrace) {
      print('[ERROR] Error retrieving message: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<MessageModel>> getRoomHistory(
    String roomId, {
    int limit = 100,
  }) async {
    try {
      if (roomId.isEmpty) {
        throw ArgumentError('Room ID cannot be empty');
      }
      final messageIds = _roomMessages[roomId] ?? [];
      if (messageIds.isEmpty) {
        print('[WARNING] No messages in room: $roomId');
        return [];
      }
      final startIndex = (messageIds.length - limit).clamp(
        0,
        messageIds.length,
      );
      final recentIds = messageIds.sublist(startIndex);
      final history = recentIds
          .map((id) => _messages[id])
          .whereType<MessageModel>()
          .toList();

      print('\n═══════════════════════════════════════');
      print('[ROOM HISTORY] $roomId');
      print('Total messages: ${history.length}');
      for (var msg in history) {
        print('  - ${msg.userId}: ${msg.text}');
      }
      print('═══════════════════════════════════════\n');

      return history;
    } catch (e, stackTrace) {
      print('[ERROR] Error retrieving room history: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }

  @override
  Future<void> markMessageAsRead(String messageId, String userId) async {
    try {
      if (messageId.isEmpty) {
        throw ArgumentError('Message ID cannot be empty');
      }
      if (userId.isEmpty) {
        throw ArgumentError('User ID cannot be empty');
      }
      final message = _messages[messageId];
      if (message == null) {
        print('[WARNING] Message not found: $messageId');
        return;
      }
      if (message.readBy.contains(userId)) {
        print('[WARNING] Message already read by: $userId');
        return;
      }
      final updatedReadBy = [...message.readBy, userId];
      _messages[messageId] = message.copyWith(readBy: updatedReadBy);
      print('[INFO] Message marked as read: $messageId by $userId');
    } catch (e, stackTrace) {
      print('[ERROR] Error marking as read: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<MessageModel>> getReadReceipts(String messageId) async {
    try {
      if (messageId.isEmpty) {
        throw ArgumentError('Message ID cannot be empty');
      }
      final message = _messages[messageId];
      if (message == null) {
        print('[WARNING] Message not found: $messageId');
        return [];
      }
      print(
        '[INFO] Retrieved read receipts for: $messageId (${message.readBy.length} users)',
      );
      return [message];
    } catch (e, stackTrace) {
      print('[ERROR] Error getting read receipts: $e');
      print('[STACKTRACE] $stackTrace');
      rethrow;
    }
  }

  // Helper: Print all messages in storage
  void printAllMessages() {
    print('\n═══════════════════════════════════════');
    print('[ALL MESSAGES IN STORAGE]');
    if (_messages.isEmpty) {
      print('No messages stored');
    } else {
      for (var entry in _messages.entries) {
        print('ID: ${entry.key}');
        print('  User: ${entry.value.userId}');
        print('  Room: ${entry.value.chatRoomId}');
        print('  Text: ${entry.value.text}');
      }
    }
    print('═══════════════════════════════════════\n');
  }
}
