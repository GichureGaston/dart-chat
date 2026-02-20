import 'dart:io';

import 'package:realtimechatapp/domain/entities/connection.dart';
import 'package:realtimechatapp/domain/repositories/connection_repo.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  @override
  Future<void> addConnection(ConnectionEntity connection) {
    // TODO: implement addConnection
    throw UnimplementedError();
  }

  @override
  Future<void> broadcastToRoom(String roomId, String message) {
    // TODO: implement broadcastToRoom
    throw UnimplementedError();
  }

  @override
  Future<ConnectionEntity?> getConnectionBySocket(Socket socket) {
    // TODO: implement getConnectionBySocket
    throw UnimplementedError();
  }

  @override
  Future<List<Socket>> getConnectionsInRoom(String roomId) {
    // TODO: implement getConnectionsInRoom
    throw UnimplementedError();
  }

  @override
  Future<List<Socket>> getUserConnections(String userId) {
    // TODO: implement getUserConnections
    throw UnimplementedError();
  }

  @override
  Future<void> removeConnection(Socket socket) {
    // TODO: implement removeConnection
    throw UnimplementedError();
  }

  @override
  Future<void> sendDirectMessage(String userId, String message) {
    // TODO: implement sendDirectMessage
    throw UnimplementedError();
  }
}
