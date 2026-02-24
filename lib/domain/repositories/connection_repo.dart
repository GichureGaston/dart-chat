import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/connection.dart';
import '../entities/message.dart';
import '../entities/user.dart';

abstract class ConnectionRepository {
  Future<Either<Failure, void>> addConnection(ConnectionEntity connection);
  Future<Either<Failure, void>> removeConnection(String socketId);
  Future<Either<Failure, List<String>>> getConnectionsInRoom(String roomId);
  Future<Either<Failure, List<String>>> getUserConnections(String userId);
  Future<Either<Failure, ConnectionEntity?>> getConnectionBySocketId(
    String socketId,
  );

  Future<Either<Failure, void>> sendDirectMessage(
    String userId,
    MessageEntity message,
  );
  Future<Either<Failure, void>> broadcastMessage(
    String roomId,
    MessageEntity message,
  );
  Future<Either<Failure, void>> broadcastTypingIndicator(
    String roomId,
    String userId,
    bool isTyping,
  );
  Future<Either<Failure, void>> broadcastPresence(
    String roomId,
    UserEntity user,
    String status,
  );
}
