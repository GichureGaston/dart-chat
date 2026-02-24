import 'package:equatable/equatable.dart';

class ConnectionEntity extends Equatable {
  const ConnectionEntity({
    required this.socketId,
    required this.userId,
    required this.roomId,
    this.id,
    this.connectedAt,
  });

  final String socketId;
  final String userId;
  final String roomId;
  final String? id;
  final DateTime? connectedAt;

  @override
  List<Object?> get props => [socketId, userId, roomId, id, connectedAt];

  ConnectionEntity copyWith({
    String? socketId,
    String? userId,
    String? roomId,
    String? id,
    DateTime? connectedAt,
  }) {
    return ConnectionEntity(
      socketId: socketId ?? this.socketId,
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      id: id ?? this.id,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }
}
