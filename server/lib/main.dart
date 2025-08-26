import 'dart:io';

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
          webSocket.add('Echo: $data');
        },
        onDone: () {
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
