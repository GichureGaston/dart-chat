import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:realtimechatapp/data/datasources/connection_data_source.dart';

import 'message_router.dart';

class TcpServer {
  final int port;
  final MessageRouter messageRouter;
  final ConnectionDataSource connectionDataSource;
  late ServerSocket _serverSocket;
  bool _serverRunning = false;
  TcpServer({
    required this.port,
    required this.messageRouter,
    required this.connectionDataSource,
  });

  Future<void> startServer() async {
    try {
      _serverSocket = await ServerSocket.bind(
        InternetAddress.loopbackIPv4,
        port,
      );
      _serverRunning = true;
      await for (Socket socket in _serverSocket) {
        handleNewClient(socket);
      }
    } catch (e) {}
  }

  void handleNewClient(Socket socket) {
    try {
      final clientAddress =
          '${socket.remoteAddress.address}:${socket.remotePort}';
      socket.listen(
        (_) {},
        onError: (error) {
          if (kDebugMode) {
            print('[ERROR] Socket error from $clientAddress: $error');
          }
          handleClientDisconnect(socket, clientAddress);
          socket.destroy();
        },
        onDone: () {
          if (kDebugMode) {
            print('[DONE] Client Disconnected $clientAddress');
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('[ERROR] Error handling new client: $e');
      }
      try {
        socket.close();
      } catch (_) {}
    }
  }

  Future<void> onDataReceived(
    List<int> data,
    Socket socket,
    String clientAddress,
  ) async {
    try {
      if (data.isEmpty) {
        if (kDebugMode) {
          print('[NOPE] Received empty data from $clientAddress');
        }
        return;
      }

      final rawMessage = String.fromCharCodes(data).trim();

      if (rawMessage.isEmpty) return;

      final messages = rawMessage.split('\n');

      for (final message in messages) {
        if (message.isEmpty) continue;

        if (kDebugMode) {
          print('\n[INFO] Received from $clientAddress:');
        }
        if (kDebugMode) {
          print('[INFO] Raw: $message');
        }

        await messageRouter.routeMessage(message, socket);
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('[ERROR] Error processing message from $clientAddress: $e');
      }
      if (kDebugMode) {
        print('[STACKTRACE] $stackTrace');
      }

      try {
        final errorResponse = jsonEncode({
          'type': 'error',
          'message': 'Invalid message format: $e',
        });
        socket.write('$errorResponse\n');
      } catch (_) {}
    }
  }

  void handleClientDisconnect(Socket socket, String clientAddress) {
    try {
      connectionDataSource.removeConnection(socket);
      if (kDebugMode) {
        print('[YOHOO]Connection Removed for$clientAddress\n');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[ERROR] Error removing client connection: $e');
      }
    }
  }

  Future<void> shutdown() async {
    if (_serverRunning) return;
    try {
      if (kDebugMode) {
        print('\n[INFO] Shutting down server...');
      }
      _serverRunning = false;
      await _serverSocket.close();
      if (kDebugMode) {
        print('[SUCCESS] Server shutdown complete');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[ERROR] Error shutting down server: $e');
      }
    }
  }
}
