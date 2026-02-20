import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/message.dart';
import '../repositories/connection_repo.dart';
import '../repositories/message_repo.dart';

class SendMessageUseCase implements UseCase<void, SendMessageParams> {
  final MessageRepository messageRepository;
  final ConnectionRepository connectionRepository;

  SendMessageUseCase({
    required this.messageRepository,
    required this.connectionRepository,
  });

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    try {
      if (params.userId.isEmpty) {
        return Left(ValidationFailure('User ID cannot be empty'));
      }
      if (params.roomId.isEmpty) {
        return Left(ValidationFailure('Room ID cannot be empty'));
      }
      if (params.text.isEmpty) {
        return Left(ValidationFailure('Message text cannot be empty'));
      }

      print('[INFO] SendMessageUseCase: Sending message from ${params.userId}');

      final message = MessageEntity(
        id: params.messageId,
        userId: params.userId,
        chatRoomId: params.roomId,
        text: params.text,
        timestamp: DateTime.now(),
      );

      print('[INFO] Message saved: ${message.id}');

      final jsonMessage = jsonEncode({
        'type': 'message',
        'data': {
          'id': message.id,
          'userId': message.userId,
          'roomId': message.chatRoomId,
          'text': message.text,
          'timestamp': message.timestamp.toString(),
        },
      });

      await connectionRepository.broadcastToRoom(params.roomId, jsonMessage);
      print('[INFO] Message broadcasted to ${params.roomId}');

      return Right(null);
    } catch (e, stackTrace) {
      print('[ERROR] Error in SendMessageUseCase: $e');
      print('[STACKTRACE] $stackTrace');

      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}

class SendMessageParams {
  final String messageId;
  final String userId;
  final String roomId;
  final String text;

  SendMessageParams({
    required this.messageId,
    required this.userId,
    required this.roomId,
    required this.text,
  });
}
