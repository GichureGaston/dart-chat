import 'dart:io';

import 'package:realtimechatapp/data/datasources/chat_room_source.dart';
import 'package:realtimechatapp/data/datasources/connection_data_source.dart';
import 'package:realtimechatapp/data/datasources/message_local_source.dart';
import 'package:realtimechatapp/data/datasources/user_local_source.dart';
import 'package:realtimechatapp/data/repositories/chat_room_repository_impl.dart';
import 'package:realtimechatapp/data/repositories/connection_repository_impl.dart';
import 'package:realtimechatapp/data/repositories/message_repository_impl.dart';
import 'package:realtimechatapp/data/repositories/user_repository_impl.dart';
import 'package:realtimechatapp/domain/usecases/get_room_history_usecase.dart';
import 'package:realtimechatapp/domain/usecases/handle_indicator_usecase.dart';
import 'package:realtimechatapp/domain/usecases/handle_user_login_usecase.dart';
import 'package:realtimechatapp/domain/usecases/send_message_usecase.dart';
import 'package:realtimechatapp/presentation/server/message_router.dart';
import 'package:realtimechatapp/presentation/server/tcp_server.dart';

void main() async {
  try {
    final messageDataSource = MessageLocalDataSourceImpl();
    final userDataSource = UserLocalDataSourceImpl();
    final roomDataSource = ChatRoomLocalDataSourceImpl();
    final connectionDataSource = ConnectionDataSourceImpl();

    final messageRepository = MessageRepositoryImpl(
      localDataSource: messageDataSource,
    );
    final userRepository = UserRepositoryImpl(localDataSource: userDataSource);
    final roomRepository = ChatRoomRepositoryImpl();
    final connectionRepository = ConnectionRepositoryImpl();

    final sendMessageUseCase = SendMessageUseCase(
      messageRepository: messageRepository,
      connectionRepository: connectionRepository,
    );

    final handleLoginUseCase = HandleUserLoginUseCase(
      userRepository: userRepository,
      roomRepository: roomRepository,
      connectionRepository: connectionRepository,
    );

    final handleTypingUseCase = HandleTypingIndicatorUseCase(
      connectionRepository: connectionRepository,
    );
    final getRoomHistoryUseCase = GetRoomHistoryUseCase(
      messageRepository: messageRepository,
    );

    final messageRouter = MessageRouter(
      sendMessageUseCase: sendMessageUseCase,
      handleLoginUseCase: handleLoginUseCase,
      getRoomHistoryUseCase: getRoomHistoryUseCase,
    );

    final server = TcpServer(
      port: 5000,
      messageRouter: messageRouter,
      connectionDataSource: connectionDataSource,
    );

    await server.startServer();
  } catch (e) {
    print('[ERROR] Fatal error: $e');

    exit(1);
  }
}
