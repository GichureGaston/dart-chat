import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/connection_repo.dart';

class HandleTypingIndicatorUseCase
    implements UseCase<void, HandleTypingIndicatorParams> {
  final ConnectionRepository connectionRepository;

  HandleTypingIndicatorUseCase({required this.connectionRepository});

  @override
  Future<Either<Failure, void>> call(HandleTypingIndicatorParams params) async {
    try {
      if (params.userId.isEmpty) {
        return Left(ValidationFailure('User ID cannot be empty'));
      }
      if (params.roomId.isEmpty) {
        return Left(ValidationFailure('Room ID cannot be empty'));
      }

      final action = params.isTyping ? 'started' : 'stopped';
      print(
        '[INFO] HandleTypingIndicatorUseCase: ${params.userId} $action typing in ${params.roomId}',
      );

      final typingMessage = jsonEncode({
        'type': 'typing',
        'data': {
          'userId': params.userId,
          'roomId': params.roomId,
          'isTyping': params.isTyping,
        },
      });

      try {
        await connectionRepository.broadcastToRoom(
          params.roomId,
          typingMessage,
        );
        print('[INFO] Typing indicator sent');
      } catch (e) {
        return Left(ConnectionFailure('Failed to send typing indicator: $e'));
      }

      return Right(null);
    } catch (e) {
      print('[ERROR] HandleTypingIndicatorUseCase error: $e');
      return Left(ConnectionFailure('Failed to handle typing: $e'));
    }
  }
}

class HandleTypingIndicatorParams {
  final String userId;
  final String roomId;
  final bool isTyping;

  HandleTypingIndicatorParams({
    required this.userId,
    required this.roomId,
    required this.isTyping,
  });
}
