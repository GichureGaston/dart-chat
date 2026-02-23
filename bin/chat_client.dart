import 'dart:convert';
import 'dart:io';

void main() async {
  print('\n[INFO] Chat Client Starting...\n');
  print('Connecting to localhost:5000...\n');

  try {
    // Connect to server
    final socket = await Socket.connect('127.0.0.1', 5000);
    print('[SUCCESS] Connected to server!\n');

    // Listen for messages from server
    socket.listen(
      (List<int> data) {
        final message = String.fromCharCodes(data).trim();
        if (message.isNotEmpty) {
          print('[SERVER] $message\n');
        }
      },
      onError: (error) {
        print('[ERROR] Socket error: $error');
      },
      onDone: () {
        print('[INFO] Disconnected from server');
        exit(0);
      },
    );

    // Interactive input loop
    print('Commands:');
    print('  login <userId> <userName> <roomId>');
    print('  message <userId> <roomId> <text>');
    print('  typing <userId> <roomId> <true/false>');
    print('  quit\n');

    // Don't set echo mode - just read input
    for (
      String? line = stdin.readLineSync();
      line != null;
      line = stdin.readLineSync()
    ) {
      final input = line.trim();

      if (input.isEmpty) continue;

      if (input == 'quit') {
        print('[INFO] Closing connection...');
        await socket.close();
        exit(0);
      }

      if (input.startsWith('login')) {
        final parts = input.split(' ');
        if (parts.length < 4) {
          print('[ERROR] Usage: login <userId> <userName> <roomId>');
          continue;
        }
        final message = jsonEncode({
          'type': 'login',
          'userId': parts[1],
          'userName': parts[2],
          'roomId': parts[3],
        });
        socket.write(message + '\n');
        print('[SENT] Login message\n');
        continue;
      }

      if (input.startsWith('message')) {
        final parts = input.split(' ');
        if (parts.length < 4) {
          print('[ERROR] Usage: message <userId> <roomId> <text>');
          continue;
        }
        final text = parts.sublist(3).join(' ');
        final message = jsonEncode({
          'type': 'message',
          'userId': parts[1],
          'roomId': parts[2],
          'text': text,
          'messageId': DateTime.now().millisecondsSinceEpoch.toString(),
        });
        socket.write(message + '\n');
        print('[SENT] Message\n');
        continue;
      }

      if (input.startsWith('typing')) {
        final parts = input.split(' ');
        if (parts.length < 4) {
          print('[ERROR] Usage: typing <userId> <roomId> <true/false>');
          continue;
        }
        final isTyping = parts[3] == 'true';
        final message = jsonEncode({
          'type': 'typing',
          'userId': parts[1],
          'roomId': parts[2],
          'isTyping': isTyping,
        });
        socket.write(message + '\n');
        print('[SENT] Typing indicator\n');
        continue;
      }

      print('[ERROR] Unknown command. Try: login, message, typing, or quit');
    }
  } catch (e, stackTrace) {
    print('[ERROR] Failed to connect: $e');
    print('[STACKTRACE] $stackTrace');
    exit(1);
  }
}
