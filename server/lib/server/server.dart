import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/domain/json/api/json_create_battle.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/battles/battle_manager.dart';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/handler.dart';
import 'package:tensionpath/utils/logger.dart';

const String X_API_KEY_HEADER = 'x-api-key';

class Server {
  final Handler handler;
  final BattleManager battleManager;
  final Environment environment;

  const Server({
    required this.battleManager,
    required this.handler,
    required this.environment,
  });

  Future start() async {
    final HttpServer server = await HttpServer.bind(
      InternetAddress.anyIPv4,
      environment.port,
    );
    server.listen(_handleRequest);
    Logger.info('Server running on ${server.port}');
  }

  Future _handleRequest(HttpRequest request) async {
    try {
      Logger.info('HTTP Request: ${request.method} ${request.requestedUri}');

      if ((request.method == 'POST') &&
          (request.uri.toString() == '/battles')) {
        await _handleBattleCreation(request);
      } else if (WebSocketTransformer.isUpgradeRequest(request)) {
        final WebSocket socket = await WebSocketTransformer.upgrade(request);
        socket.listen(
          (message) => _onMessage(socket, message),
          onDone: () => handler.onDisconnect(socket),
          onError: (error) => handler.onError(socket, error),
        );
        handler.onConnect(socket);
      } else {
        Logger.info('Request cannot be upgraded');

        request.response.statusCode = HttpStatus.forbidden;
        await request.response.close();
      }
    } catch (e) {
      Logger.error(e);
    }
  }

  void _onMessage(WebSocket socket, String message) {
    try {
      handler.onMessage(socket, JsonMessage.fromString(message));
    } catch (e) {
      Logger.log(socket, 'Exception: $e');
    }
  }

  Future _handleBattleCreation(HttpRequest request) async {
    final String? apiKey = request.headers[X_API_KEY_HEADER]?[0];

    if (apiKey == environment.apiKey) {
      final String content = await utf8.decodeStream(request);
      final JsonCreateBattle json = JsonCreateBattle.fromString(content);

      battleManager.create(json);

      request.response.statusCode = HttpStatus.created;
    } else {
      request.response.statusCode = HttpStatus.unauthorized;
    }

    await request.response.close();
  }
}
