import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/message.dart';
import '../repositories/message_repo.dart';

class GetRoomHistoryUseCase
    implements UseCase<List<MessageEntity>, GetRoomHistoryParams> {
  final MessageRepository messageRepository;

  GetRoomHistoryUseCase({required this.messageRepository});

  @override
  Future<Either<Failure, List<MessageEntity>>> call(
    GetRoomHistoryParams params,
  ) async {
    if (params.roomId.isEmpty) {
      return Left(ValidationFailure('Room ID cannot be empty'));
    }
    if (params.limit <= 0) {
      return Left(ValidationFailure('Limit must be greater than 0'));
    }

    return messageRepository.getChatRoomHistory(
      params.roomId,
      limit: params.limit,
    );
  }
}

class GetRoomHistoryParams {
  final String roomId;
  final int limit;

  GetRoomHistoryParams({required this.roomId, this.limit = 100});
}
