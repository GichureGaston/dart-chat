import 'dart:io';

import 'package:equatable/equatable.dart';

class ConnectionEntity extends Equatable {
  const ConnectionEntity({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.socket,
    required this.connectedAt,
  });

  final String id;
  final String userId;
  final String roomId;
  final Socket socket;
  final DateTime connectedAt;

  @override
  List<Object?> get props => [id, userId, roomId, socket, connectedAt];

  ConnectionEntity copyWith({
    String? id,
    String? userId,
    String? roomId,
    Socket? socket,
    DateTime? connectedAt,
  }) {
    return ConnectionEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      socket: socket ?? this.socket,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }
}
