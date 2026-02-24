import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:realtimechatapp/core/errors/failures.dart';
import 'package:realtimechatapp/domain/entities/connection.dart';
import 'package:realtimechatapp/domain/entities/message.dart';
import 'package:realtimechatapp/domain/entities/user.dart';
import 'package:realtimechatapp/domain/repositories/connection_repo.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  final Map<String, Socket> _sockets = {};
  final Map<String, ConnectionEntity> _connections = {};
  final Map<String, Set<String>> _roomConnections = {};
  final Map<String, Set<String>> _userConnections = {};

  void registerSocket(String socketId, Socket socket) {
    _sockets[socketId] = socket;
  }

  @override
  Future<Either<Failure, void>> addConnection(
    ConnectionEntity connection,
  ) async {
    try {
      _connections[connection.socketId] = connection;
      _roomConnections
          .putIfAbsent(connection.roomId, () => {})
          .add(connection.socketId);
      _userConnections
          .putIfAbsent(connection.userId, () => {})
          .add(connection.socketId);
      return const Right(null);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeConnection(String socketId) async {
    try {
      final connection = _connections.remove(socketId);
      if (connection != null) {
        _roomConnections[connection.roomId]?.remove(socketId);
        _userConnections[connection.userId]?.remove(socketId);
      }
      _sockets.remove(socketId);
      return const Right(null);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getConnectionsInRoom(
    String roomId,
  ) async {
    try {
      return Right(_roomConnections[roomId]?.toList() ?? []);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUserConnections(
    String userId,
  ) async {
    try {
      return Right(_userConnections[userId]?.toList() ?? []);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConnectionEntity?>> getConnectionBySocketId(
    String socketId,
  ) async {
    try {
      return Right(_connections[socketId]);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> broadcastMessage(
    String roomId,
    MessageEntity message,
  ) async {
    try {
      final payload = jsonEncode({
        'type': 'message',
        'data': {
          'id': message.id,
          'userId': message.userId,
          'roomId': message.chatRoomId,
          'text': message.text,
          'timestamp': message.timestamp.toIso8601String(),
        },
      });
      return _broadcastPayload(roomId, payload);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> broadcastPresence(
    String roomId,
    UserEntity user,
    String status,
  ) async {
    try {
      final payload = jsonEncode({
        'type': 'presence',
        'data': {
          'userId': user.id,
          'userName': user.name,
          'status': status,
          'roomId': roomId,
        },
      });
      return _broadcastPayload(roomId, payload);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> broadcastTypingIndicator(
    String roomId,
    String userId,
    bool isTyping,
  ) async {
    try {
      final payload = jsonEncode({
        'type': 'typing',
        'data': {'userId': userId, 'roomId': roomId, 'isTyping': isTyping},
      });
      return _broadcastPayload(roomId, payload);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> _broadcastPayload(
    String roomId,
    String payload,
  ) async {
    try {
      final socketIds = _roomConnections[roomId] ?? {};
      for (final socketId in socketIds) {
        _sockets[socketId]?.write('$payload\n');
      }
      return const Right(null);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendDirectMessage(
    String userId,
    MessageEntity message,
  ) {
    // TODO: implement sendDirectMessage
    throw UnimplementedError();
  }
}
