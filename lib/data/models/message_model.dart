import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable(checked: true)
class MessageModel {
  MessageModel({
    required this.id,
    this.userId,
    required this.chatRoomId,
    this.text,
    this.timeStamp,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  final String id;
  final String? userId;
  final String chatRoomId;
  final String? text;
  final String? timeStamp;
  MessageModel copyWith({
    String? id,
    String? userId,
    String? chatRoomId,
    String? text,
    String? timeStamp,
  }) {
    return MessageModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      text: text ?? this.text,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}
