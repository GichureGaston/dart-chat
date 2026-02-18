import 'package:json_annotation/json_annotation.dart';

part 'chat_room_model.g.dart';

@JsonSerializable(checked: true)
class ChatRoomModel {
  ChatRoomModel({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    required this.members,
  });
  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final Set<String> members;
  ChatRoomModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    Set<String>? members,
  }) {
    return ChatRoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      members: members ?? this.members,
    );
  }
}
