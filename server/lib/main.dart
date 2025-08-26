import 'dart:io';

bool running = true;

Future main() async {
  final int port = int.parse(Platform.environment['PORT'] ?? '8080');
  final HttpServer server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    port,
  );
  print('Listening on port $port');

  await for (final HttpRequest request in server) {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      final WebSocket webSocket = await WebSocketTransformer.upgrade(request);
      print('Client connected');

      webSocket.listen(
        (data) {
          print('Received: $data');

          if (data == 'start') {
            if (!running) {
              running = true;
              gameLoop();
              webSocket.add('Game started');
            } else {
              webSocket.add('Game already running');
            }
          } else if (data == 'stop') {
            if (running) {
              running = false;
              webSocket.add('Game stopped');
            } else {
              webSocket.add('Game already stopped');
            }
          }
        },
        onDone: () {
          running = false;
          print('Client disconnected');
        },
      );
    } else {
      request.response.statusCode = HttpStatus.forbidden;
      request.response.write('WebSocket connections only');
      await request.response.close();
    }
  }
}

Future gameLoop() async {
  while (running) {
    await Future.delayed(const Duration(seconds: 1));
    print('Game tick');
  }
}
