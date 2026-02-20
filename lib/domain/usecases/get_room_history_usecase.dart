import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/message_repo.dart';

class GetRoomHistoryUseCase implements UseCase<void, GetRoomHistoryParams> {
  final MessageRepository messageRepository;

  GetRoomHistoryUseCase({required this.messageRepository});

  @override
  Future<Either<Failure, void>> call(GetRoomHistoryParams params) async {
    try {
      if (params.roomId.isEmpty) {
        return Left(ValidationFailure('Room ID cannot be empty'));
      }
      if (params.limit <= 0) {
        return Left(ValidationFailure('Limit must be greater than 0'));
      }

      print(
        '[INFO] GetRoomHistoryUseCase: Fetching ${params.limit} messages from ${params.roomId}',
      );

      // FETCH HISTORY
      final history = await messageRepository.getChatRoomHistory(
        params.roomId,
        limit: params.limit,
      );

      if (history == null) {}

      print('[INFO] Retrieved ${history.length} messages');

      final historyMessage = jsonEncode({
        'type': 'room_history',
        'data': {
          'roomId': params.roomId,
          'count': history.length,
          'messages': history
              .map(
                (message) => {
                  'id': message.id,
                  'userId': message.userId,
                  'text': message.text,
                  'timestamp': message.timeStamp.toString(),
                },
              )
              .toList(),
        },
      });

      try {
        params.socket.write('$historyMessage\n');
        print('[INFO] History sent to client');
      } catch (e) {
        return Left(ConnectionFailure('Failed to send history: $e'));
      }

      return Right(null);
    } catch (e, stackTrace) {
      print('[ERROR] Error in GetRoomHistoryUseCase: $e');
      print('[STACKTRACE] $stackTrace');
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}

class GetRoomHistoryParams {
  final String roomId;
  final Socket socket;
  final int limit;

  GetRoomHistoryParams({
    required this.roomId,
    required this.socket,
    this.limit = 100,
  });
}
