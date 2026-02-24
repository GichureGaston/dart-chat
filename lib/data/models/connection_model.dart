import 'package:json_annotation/json_annotation.dart';

part 'connection_model.g.dart';

@JsonSerializable(checked: true)
class ConnectionModel {
  ConnectionModel({
    required this.socketId,
    required this.userId,
    required this.roomId,
    this.id,
    this.connectedAt,
  });

  factory ConnectionModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectionModelFromJson(json);

  final String socketId;
  final String userId;
  final String roomId;
  final String? id;
  final DateTime? connectedAt;
  Map<String, dynamic> toJson() => _$ConnectionModelToJson(this);

  ConnectionModel copyWith({
    String? socketId,
    String? userId,
    String? roomId,
    String? id,
    DateTime? connectedAt,
  }) {
    return ConnectionModel(
      socketId: socketId ?? this.socketId,
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      id: id ?? this.id,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }
}
