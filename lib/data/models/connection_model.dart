import 'package:json_annotation/json_annotation.dart';

part 'connection_model.g.dart';

@JsonSerializable(checked: true)
class ConnectionModel {
  ConnectionModel({this.id, this.userId, this.roomId, this.connectedAt});
  factory ConnectionModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectionModelFromJson(json);
  final String? id;
  final String? userId;
  final String? roomId;
  final DateTime? connectedAt;
  ConnectionModel copyWith({
    String? id,
    String? userId,
    String? roomId,
    DateTime? connectedAt,
  }) {
    return ConnectionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }
}
