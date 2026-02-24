import '../../domain/entities/connection.dart';
import '../models/connection_model.dart';

class ConnectionMapper {
  static ConnectionModel toModel(ConnectionEntity entity) {
    return ConnectionModel(
      socketId: entity.socketId,
      userId: entity.userId,
      roomId: entity.roomId,
      id: entity.id,
      connectedAt: entity.connectedAt,
    );
  }

  static ConnectionEntity toEntity(ConnectionModel model) {
    return ConnectionEntity(
      socketId: model.socketId,
      userId: model.userId,
      roomId: model.roomId,
      id: model.id,
      connectedAt: model.connectedAt,
    );
  }
}
