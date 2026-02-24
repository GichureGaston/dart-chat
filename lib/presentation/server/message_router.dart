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

  Future<void> routeMessage(
    String jsonData,
    Socket socket,
    String socketId,
  ) async {
    late final Map<String, dynamic> decoded;
    try {
      decoded = jsonDecode(jsonData) as Map<String, dynamic>;
    } catch (e) {
      _sendError(socket, 'Invalid JSON: $e');
      return;
    }

    final type = decoded['type'] as String?;
    if (type == null) {
      _sendError(socket, 'Message type is required');
      return;
    }

    switch (type) {
      case 'login':
        final params = HandleUserLoginParams(
          userId: decoded['userId'] ?? '',
          userName: decoded['userName'] ?? '',
          roomId: decoded['roomId'] ?? '',
          socketId: socketId,
        );

        final result = await handleLoginUseCase(params);
        result.fold(
          (failure) => _sendError(socket, failure.message),
          (_) => socket.write(
            '${jsonEncode({
              'type': 'login_success',
              'data': {'userId': params.userId, 'roomId': params.roomId, 'message': 'Welcome ${params.userName}!'},
            })}\n',
          ),
        );
        break;

      case 'message':
        final params = SendMessageParams(
          messageId: decoded['messageId'] ?? '',
          userId: decoded['userId'] ?? '',
          roomId: decoded['roomId'] ?? '',
          text: decoded['text'] ?? '',
        );

        final result = await sendMessageUseCase(params);
        result.fold(
          (failure) => _sendError(socket, failure.message),
          (_) => null,
        );
        break;

      case 'history':
        final params = GetRoomHistoryParams(roomId: decoded['roomId'] ?? '');

        final result = await getRoomHistoryUseCase(params);
        result.fold(
          (failure) => _sendError(socket, failure.message),
          (messages) => socket.write(
            '${jsonEncode({
              'type': 'history',
              'data': messages.map((m) => {'id': m.id, 'userId': m.userId, 'text': m.text, 'timestamp': m.timestamp.toIso8601String()}).toList(),
            })}\n',
          ),
        );
        break;

      default:
        _sendError(socket, 'Unknown message type: $type');
    }
  }

  void _sendError(Socket socket, String message) {
    socket.write('${jsonEncode({'type': 'error', 'message': message})}\n');
  }
}
