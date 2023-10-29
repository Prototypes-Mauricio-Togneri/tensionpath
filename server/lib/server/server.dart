import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/json/json_create_room.dart';
import 'package:tensionpath/json/json_message.dart';
import 'package:tensionpath/rooms/rooms_manager.dart';
import 'package:tensionpath/server/handler.dart';
import 'package:tensionpath/utils/logger.dart';

class Server {
  final Handler handler;
  final RoomsManager roomsManager;

  const Server(this.roomsManager, this.handler);

  Future start(int port) async {
    final String chain =
        Platform.script.resolve('/home/max/fullchain.pem').toFilePath();
    final String key =
        Platform.script.resolve('/home/max/privkey.pem').toFilePath();
    final SecurityContext context = SecurityContext()
      ..useCertificateChain(chain)
      ..usePrivateKey(
        key,
        password: '',
      );

    final HttpServer server = await HttpServer.bindSecure(
      InternetAddress.anyIPv4,
      port,
      context,
    );
    print('Server running on ${server.port}');

    server.listen(_handleRequest);
  }

  Future _handleRequest(HttpRequest request) async {
    if ((request.method == 'POST') && (request.uri.toString() == '/rooms')) {
      _handleRoomCreation(request);
    } else if (WebSocketTransformer.isUpgradeRequest(request)) {
      final WebSocket socket = await WebSocketTransformer.upgrade(request);
      socket.listen(
        (message) => _onMessage(socket, message),
        onDone: () => handler.onDisconnect(socket),
        onError: (error) => handler.onError(socket, error),
      );
      handler.onConnect(socket);
    } else {
      print('Request cannot be upgraded');

      request.response.statusCode = HttpStatus.forbidden;
      request.response.close();
    }
  }

  void _onMessage(WebSocket socket, String message) {
    try {
      handler.onMessage(socket, JsonMessage.fromString(message));
    } catch (e) {
      Logger.log(socket, 'Exception: $e');
    }
  }

  Future _handleRoomCreation(HttpRequest request) async {
    final String? apiKey = request.headers['X-API-Key']?[0];

    // TODO(momo): externalize
    if (apiKey == 'API_KEY') {
      final String content = await utf8.decodeStream(request);
      final JsonCreateRoom json = JsonCreateRoom.fromString(content);

      roomsManager.create(json);

      request.response.statusCode = HttpStatus.created;
    } else {
      request.response.statusCode = HttpStatus.unauthorized;
    }

    request.response.close();
  }
}
