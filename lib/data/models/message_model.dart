import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable(checked: true)
class MessageModel {
  final String id;
  final String userId;
  final String chatRoomId;
  final String text;
  final DateTime timestamp;
  final List<String> readBy;

  MessageModel({
    required this.id,
    required this.userId,
    required this.chatRoomId,
    required this.text,
    required this.timestamp,
    this.readBy = const [],
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  MessageModel copyWith({
    String? id,
    String? userId,
    String? chatRoomId,
    String? text,
    DateTime? timestamp,
    List<String>? readBy,
  }) {
    return MessageModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      readBy: readBy ?? this.readBy,
    );
  }
}
