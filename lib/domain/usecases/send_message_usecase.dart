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
    if (params.userId.isEmpty) {
      return Left(ValidationFailure('User ID cannot be empty'));
    }
    if (params.roomId.isEmpty) {
      return Left(ValidationFailure('Room ID cannot be empty'));
    }
    if (params.text.isEmpty) {
      return Left(ValidationFailure('Message text cannot be empty'));
    }
    if (params.messageId.isEmpty) {
      return Left(ValidationFailure('Message ID cannot be empty'));
    }

    final message = MessageEntity(
      id: params.messageId,
      userId: params.userId,
      chatRoomId: params.roomId,
      text: params.text,
      timestamp: DateTime.now(),
    );

    final saveResult = await messageRepository.saveMessage(message);
    if (saveResult.isLeft()) return saveResult;

    return connectionRepository.broadcastMessage(params.roomId, message);
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
