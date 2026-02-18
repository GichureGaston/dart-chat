import 'dart:io';

import '../models/connection_model.dart';

abstract class ConnectionDataSource {
  Future<void> addConnection(ConnectionModel model, Socket socket);
  Future<void> removeConnection(Socket socket);
  Future<List<Socket>> getConnectionsInRoom(String roomId);
  Future<List<Socket>> getUserConnections(String userId);
  Future<void> broadcastToRoom(String roomId, String message);
  Future<void> sendDirectMessage(String userId, String message);
}

class ConnectionDataSourceImpl implements ConnectionDataSource {
  @override
  Future<void> addConnection(ConnectionModel model, Socket socket) {
    // TODO: implement addConnection
    throw UnimplementedError();
  }

  @override
  Future<void> broadcastToRoom(String roomId, String message) {
    // TODO: implement broadcastToRoom
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
