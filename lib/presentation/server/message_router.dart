import 'dart:convert';
import 'dart:io';

import 'package:realtimechatapp/domain/usecases/get_room_history_usecase.dart';
import 'package:realtimechatapp/domain/usecases/handle_user_login_usecase.dart';
import 'package:realtimechatapp/domain/usecases/send_message_usecase.dart';

class MessageRouter {
  final SendMessageUseCase sendMessageUseCase;
  final HandleUserLoginUseCase handleLoginUseCase;
  final GetRoomHistoryUseCase getRoomHistoryUseCase;
  const MessageRouter({
    required this.sendMessageUseCase,
    required this.handleLoginUseCase,
    required this.getRoomHistoryUseCase,
  });
  Future<void> routeMessage(String jsonData, Socket socket) async {
    try {
      final decoded = jsonDecode(jsonData) as Map<String, dynamic>;
      final type = decoded['type'] as String?;

      switch (type) {
        case 'message':
          final params = SendMessageParams(
            messageId: decoded['messageId'],
            userId: decoded['userId'],
            roomId: decoded['roomId'],
            text: decoded['text'],
          );

          // CALL USECASE (returns Either)
          final result = await sendMessageUseCase(params);

          // HANDLE RESULT
          result.fold(
            (failure) {
              // LEFT: Error occurred
              print('[ERROR] ${failure.message}');
              final errorResponse = jsonEncode({
                'type': 'error',
                'message': failure.message,
              });
              socket.write('$errorResponse\n');
            },
            (success) {
              // RIGHT: Success
              print('[SUCCESS] Message sent and broadcasted');
            },
          );
          break;

        case 'login':
          final params = HandleUserLoginParams(
            userId: decoded['userId'],
            userName: decoded['userName'],
            roomId: decoded['roomId'],
            socket: socket,
          );

          final result = await handleLoginUseCase(params);

          result.fold(
            (failure) => print('[ERROR] ${failure.message}'),
            (success) => print('[SUCCESS] User logged in'),
          );
          break;

        // ... other cases ...
      }
    } catch (e) {
      print('[ERROR] Error routing message: $e');
    }
  }
}
