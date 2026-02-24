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
    if (params.userId.isEmpty) {
      return Left(ValidationFailure('User ID cannot be empty'));
    }
    if (params.roomId.isEmpty) {
      return Left(ValidationFailure('Room ID cannot be empty'));
    }

    return connectionRepository.broadcastTypingIndicator(
      params.roomId,
      params.userId,
      params.isTyping,
    );
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
