// lib/domain/usecases/handle_user_login_usecase.dart

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:realtimechatapp/domain/repositories/chat_room_repo.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/connection.dart';
import '../entities/user.dart';
import '../repositories/connection_repo.dart';
import '../repositories/user_repo.dart';

class HandleUserLoginUsecase implements UseCase<void, HandleUserLoginParams> {
  final UserRepository userRepository;
  final ChatRoomRepository roomRepository;
  final ConnectionRepository connectionRepository;

  HandleUserLoginUsecase({
    required this.userRepository,
    required this.roomRepository,
    required this.connectionRepository,
  });

  @override
  Future<Either<Failure, void>> call(HandleUserLoginParams params) async {
    try {
      // VALIDATION
      if (params.userId.isEmpty) {
        return Left(ValidationFailure('User ID cannot be empty'));
      }
      if (params.userName.isEmpty) {
        return Left(ValidationFailure('User name cannot be empty'));
      }
      if (params.roomId.isEmpty) {
        return Left(ValidationFailure('Room ID cannot be empty'));
      }

      print('[INFO] HandleUserLoginUsecase: ${params.userId} logging in');

      final user = UserEntity(
        id: params.userId,
        name: params.userName,
        status: 'online',
      );

      try {
        await roomRepository.addUserToRoom(params.roomId, params.userId);
        print('[INFO] User added to room: ${params.roomId}');
      } catch (e) {
        return Left(StorageFailure('Failed to add user to room: $e'));
      }

      const uuid = Uuid();
      final connection = ConnectionEntity(
        id: uuid.v4(),
        userId: params.userId,
        roomId: params.roomId,
        socket: params.socket,
        connectedAt: DateTime.now(),
      );

      try {
        await connectionRepository.addConnection(connection);
        print('[INFO] Connection tracked: ${connection.id}');
      } catch (e) {
        return Left(ConnectionFailure('Failed to track connection: $e'));
      }

      final presenceMessage = jsonEncode({
        'type': 'presence',
        'data': {
          'userId': params.userId,
          'userName': params.userName,
          'status': 'online',
          'roomId': params.roomId,
        },
      });

      await connectionRepository.broadcastToRoom(
        params.roomId,
        presenceMessage,
      );
      print('[INFO] Presence announced');

      final confirmMessage = jsonEncode({
        'type': 'login_success',
        'data': {
          'userId': params.userId,
          'roomId': params.roomId,
          'message': 'Welcome ${params.userName}!',
        },
      });

      try {
        params.socket.write(confirmMessage + '\n');
        print('[INFO] Login confirmation sent');
      } catch (e) {
        return Left(ConnectionFailure('Failed to send confirmation: $e'));
      }

      return Right(null);
    } catch (e, stackTrace) {
      print('[ERROR] Error in HandleUserLoginUsecase: $e');
      print('[STACKTRACE] $stackTrace');
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}

class HandleUserLoginParams {
  final String userId;
  final String userName;
  final String roomId;
  final Socket socket;

  HandleUserLoginParams({
    required this.userId,
    required this.userName,
    required this.roomId,
    required this.socket,
  });
}
