import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  const MessageEntity({
    this.id,
    this.userId,
    this.text,
    this.timeStamp,
    this.chatRoomId,
  });
  final String? id;
  final String? userId;
  final String? chatRoomId;
  final String? text;
  final String? timeStamp;

  @override
  List<Object?> get props => [id, userId, chatRoomId, text, timeStamp];
  MessageEntity copyWith({
    String? id,
    String? userId,
    String? chatRoomId,
    String? text,
    String? timestamp,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      text: text ?? this.text,
      timeStamp: timeStamp ?? timeStamp,
    );
  }
}
