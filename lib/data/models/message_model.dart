import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable(checked: true)
class MessageModel {
  MessageModel({
    this.id,
    this.userId,
    this.chatRoomId,
    this.text,
    this.timeStamp,
    this.readBy,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  final String? id;
  final String? userId;
  final String? chatRoomId;
  final String? text;
  final String? timeStamp;
  final String? readBy;
  MessageModel copyWith({
    String? id,
    String? userId,
    String? chatRoomId,
    String? text,
    String? timeStamp,
    String? readBy,
  }) {
    return MessageModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      text: text ?? this.text,
      timeStamp: timeStamp ?? this.timeStamp,
      readBy: readBy ?? this.readBy,
    );
  }
}
