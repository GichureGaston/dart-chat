import 'package:dartz/dartz.dart';
import 'package:realtimechatapp/domain/repositories/chat_room_repo.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/connection.dart';
import '../entities/user.dart';
import '../repositories/connection_repo.dart';
import '../repositories/user_repo.dart';

class HandleUserLoginUseCase implements UseCase<void, HandleUserLoginParams> {
  final UserRepository userRepository;
  final ChatRoomRepository roomRepository;
  final ConnectionRepository connectionRepository;

  HandleUserLoginUseCase({
    required this.userRepository,
    required this.roomRepository,
    required this.connectionRepository,
  });

  @override
  Future<Either<Failure, void>> call(HandleUserLoginParams params) async {
    if (params.userId.isEmpty) {
      return Left(ValidationFailure('User ID cannot be empty'));
    }
    if (params.userName.isEmpty) {
      return Left(ValidationFailure('User name cannot be empty'));
    }
    if (params.roomId.isEmpty) {
      return Left(ValidationFailure('Room ID cannot be empty'));
    }
    if (params.socketId.isEmpty) {
      return Left(ValidationFailure('Socket ID cannot be empty'));
    }

    final user = UserEntity(
      id: params.userId,
      name: params.userName,
      status: 'online',
    );

    final saveResult = await userRepository.saveUser(user: user);
    if (saveResult.isLeft()) return saveResult;

    final roomResult = await roomRepository.addUserToRoom(
      params.roomId,
      params.userId,
    );
    if (roomResult.isLeft()) return roomResult;

    final connection = ConnectionEntity(
      id: const Uuid().v4(),
      userId: params.userId,
      roomId: params.roomId,
      socketId: params.socketId,
      connectedAt: DateTime.now(),
    );

    final connectionResult = await connectionRepository.addConnection(
      connection,
    );
    if (connectionResult.isLeft()) return connectionResult;

    return connectionRepository.broadcastPresence(
      params.roomId,
      user,
      'online',
    );
  }
}

class HandleUserLoginParams {
  final String userId;
  final String userName;
  final String roomId;
  final String socketId;

  HandleUserLoginParams({
    required this.userId,
    required this.userName,
    required this.roomId,
    required this.socketId,
  });
}
