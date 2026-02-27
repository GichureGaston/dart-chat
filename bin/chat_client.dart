import 'dart:convert';
import 'dart:io';

void main() async {
  print('\n[INFO] Chat Client Starting...\n');
  print('Connecting to localhost:5000...\n');

  try {
    final socket = await Socket.connect('127.0.0.1', 5000);
    print('[SUCCESS] Connected to server!\n');
    print('Commands:');
    print('  login <userId> <userName> <roomId>');
    print('  message <userId> <roomId> <text>');
    print('  quit\n');
    final StringBuffer receiveBuffer = StringBuffer();

    void streamProcessBuffer() {
      while (true) {
        final bufferContent = receiveBuffer.toString();
        final newlineIndex = bufferContent.indexOf('\n');

        if (newlineIndex == -1) {
          break;
        }

        final message = bufferContent.substring(0, newlineIndex).trim();

    socket.listen(
      (List<int> data) {
        final messages = String.fromCharCodes(data).trim().split('\n');
        for (final message in messages) {
          if (message.isEmpty) continue;
          try {
            final decoded = jsonDecode(message);
            final type = decoded['type'];
            if (type == 'message') {
              final d = decoded['data'];
              print('\n[${d['userId']}] ${d['text']}\n');
            } else if (type == 'presence') {
              final d = decoded['data'];
              print('\n[PRESENCE] ${d['userName']} is ${d['status']}\n');
            } else if (type == 'login_success') {
              final d = decoded['data'];
              print('\n[LOGIN] ${d['message']}\n');
            } else if (type == 'error') {
              print('\n[ERROR] ${decoded['message']}\n');
            } else {
              print('\n[SERVER] $message\n');
            }
          } catch (_) {
            print('\n[SERVER] $message\n');
          }
        }
      },
      onError: (error) => print('[ERROR] $error'),
      onDone: () {
        print('[INFO] Disconnected from server');
        exit(0);
      },
    );

    final inputStream = stdin
        .transform(SystemEncoding().decoder)
        .transform(const LineSplitter());

    await for (final line in inputStream) {
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
        socket.write(
          '${jsonEncode({'type': 'login', 'userId': parts[1], 'userName': parts[2], 'roomId': parts[3]})}\n',
        );
        continue;
      }

      if (input.startsWith('message')) {
        final parts = input.split(' ');
        if (parts.length < 4) {
          print('[ERROR] Usage: message <userId> <roomId> <text>');
          continue;
        }
        socket.write(
          '${jsonEncode({'type': 'message', 'messageId': DateTime.now().millisecondsSinceEpoch.toString(), 'userId': parts[1], 'roomId': parts[2], 'text': parts.sublist(3).join(' ')})}\n',
        );
        continue;
      }

      print('[ERROR] Unknown command. Try: login, message, or quit');
    }
  } catch (e) {
    print('[ERROR] Failed to connect: $e');
    exit(1);
  }
}
