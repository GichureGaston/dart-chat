import 'package:equatable/equatable.dart';

class ChatRoomEntity extends Equatable {
  const ChatRoomEntity({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.members = const {},
  });

  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final Set<String> members;

  @override
  List<Object?> get props => [id, name, description, createdAt, members];

  ChatRoomEntity copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    Set<String>? members,
  }) {
    return ChatRoomEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      members: members ?? this.members,
    );
  }

  ChatRoomEntity addMember(String userId) {
    return copyWith(members: {...members, userId});
  }

  ChatRoomEntity removeMember(String userId) {
    final updated = {...members};
    updated.remove(userId);
    return copyWith(members: updated);
  }
}
