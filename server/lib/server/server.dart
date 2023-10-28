import 'dart:convert';
import 'dart:io';
import 'package:tensionbase/json/json_create_room.dart';
import 'package:tensionbase/json/json_message.dart';
import 'package:tensionbase/rooms/rooms_manager.dart';
import 'package:tensionbase/server/handler.dart';
import 'package:tensionbase/utils/logger.dart';

class Server {
  final Handler handler;
  final RoomsManager roomsManager;

  const Server(this.roomsManager, this.handler);

  Future start(int port) async {
    // TODO: only for testing
    roomsManager.create(const JsonCreateRoom(roomId: 'abc'));

    final HttpServer server =
        await HttpServer.bind(InternetAddress.anyIPv4, port);
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
    final String content = await utf8.decodeStream(request);
    final JsonCreateRoom json = JsonCreateRoom.fromString(content);
    roomsManager.create(json);

    request.response.statusCode = HttpStatus.created;
    request.response.close();
  }
}
