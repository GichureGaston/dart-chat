import 'dart:convert';
import 'dart:io';

import 'package:realtimechatapp/data/repositories/connection_repository_impl.dart';

import 'message_router.dart';

class TcpServer {
  final int port;
  final MessageRouter messageRouter;
  final ConnectionRepositoryImpl connectionRepository;

  late ServerSocket _serverSocket;
  bool _serverRunning = false;

  TcpServer({
    required this.port,
    required this.messageRouter,
    required this.connectionRepository,
  });

  Future<void> startServer() async {
    _serverSocket = await ServerSocket.bind(InternetAddress.loopbackIPv4, port);
    _serverRunning = true;
    print('[INFO] Server started on port $port');

    await for (final socket in _serverSocket) {
      handleNewClient(socket);
    }
  }

  void handleNewClient(Socket socket) {
    final socketId = '${socket.remoteAddress.address}:${socket.remotePort}';

    connectionRepository.registerSocket(socketId, socket);

    socket.listen(
      (data) => onDataReceived(data, socket, socketId),
      onError: (error) {
        handleClientDisconnect(socket, socketId);
        socket.destroy();
      },
      onDone: () => handleClientDisconnect(socket, socketId),
    );
  }

  Future<void> onDataReceived(
    List<int> data,
    Socket socket,
    String socketId,
  ) async {
    if (data.isEmpty) return;

    final rawMessage = String.fromCharCodes(data).trim();
    if (rawMessage.isEmpty) return;

    for (final message in rawMessage.split('\n')) {
      if (message.isEmpty) continue;
      try {
        await messageRouter.routeMessage(message, socket, socketId);
      } catch (e) {
        final errorResponse = jsonEncode({
          'type': 'error',
          'message': 'Invalid message format: $e',
        });
        socket.write('$errorResponse\n');
      }
    }
  }

  void handleClientDisconnect(Socket socket, String socketId) {
    connectionRepository.removeConnection(socketId);
    socket.destroy();
  }

  Future<void> shutdown() async {
    if (!_serverRunning) return;
    _serverRunning = false;
    await _serverSocket.close();
  }
}
