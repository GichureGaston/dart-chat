import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  const MessageEntity({
    required this.id,
    required this.userId,
    required this.chatRoomId,
    required this.text,
    required this.timestamp,
    this.readBy = const {},
  });

  final String id;
  final String userId;
  final String chatRoomId;
  final String text;
  final DateTime timestamp;
  final Set<String> readBy;

  @override
  List<Object?> get props => [id, userId, chatRoomId, text, timestamp, readBy];

  MessageEntity copyWith({
    String? id,
    String? userId,
    String? chatRoomId,
    String? text,
    DateTime? timestamp,
    Set<String>? readBy,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      readBy: readBy ?? this.readBy,
    );
  }
}
