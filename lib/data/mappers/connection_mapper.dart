import '../../domain/entities/connection.dart';
import '../models/connection_model.dart';

class ConnectionMapper {
  static ConnectionModel toModel(ConnectionEntity entity) {
    return ConnectionModel(
      id: entity.id,
      userId: entity.userId,
      roomId: entity.roomId,
      connectedAt: entity.connectedAt,
    );
  }

  static ConnectionEntity toEntity(ConnectionModel model, socket) {
    return ConnectionEntity(
      id: '',
      userId: '',
      roomId: '',
      socket: socket,
      connectedAt: model.connectedAt,
    );
  }
}
