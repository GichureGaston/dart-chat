import 'dart:io';

import '../entities/connection.dart';

abstract class ConnectionRepository {
  Future<void> addConnection(ConnectionEntity connection);
  Future<void> removeConnection(Socket socket);
  Future<List<Socket>> getConnectionsInRoom(String roomId);
  Future<List<Socket>> getUserConnections(String userId);
  Future<ConnectionEntity?> getConnectionBySocket(Socket socket);
  Future<void> broadcastToRoom(String roomId, String message);
  Future<void> sendDirectMessage(String userId, String message);
}
