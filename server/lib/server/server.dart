import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/domain/json/api/json_create_match.dart';
import 'package:tensionpath/domain/json/api/json_player.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/server/dispatcher.dart';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/handler.dart';
import 'package:tensionpath/utils/logger.dart';

const String X_API_KEY_HEADER = 'x-api-key';

class Server {
  final Dispatcher dispatcher;
  final Handler handler;
  final Environment environment;

  const Server({
    required this.dispatcher,
    required this.handler,
    required this.environment,
  });

  Future start() async {
    final HttpServer server = await HttpServer.bind(
      InternetAddress.anyIPv4,
      environment.port,
    );
    server.listen(_handleRequest);
    Logger.info('Server running...');
    Logger.info('· API Key: ${environment.maskedApiKey}');
    Logger.info('· Port: ${environment.port}');
    Logger.info('· Create Test Match: ${environment.createTestMatch}');
    Logger.info('· Show Logs: ${environment.showLogs}');

    if (environment.createTestMatch) {
      await _startTestMatch();
    }
  }

  Future _handleRequest(HttpRequest request) async {
    try {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        final WebSocket socket = await WebSocketTransformer.upgrade(request);
        socket.listen(
          (message) => _onMessage(socket, message),
          onDone: () => _onDisconnect(socket),
          onError: (error) => _onError(socket, error),
        );
        _onConnect(socket);
      } else if ((request.method == 'POST') &&
          (request.uri.toString() == '/matches')) {
        await _handleMatchCreation(request);
      } else if ((request.method == 'GET') && (request.uri.toString() == '/')) {
        await _handleGreeting(request);
      } else {
        /*Logger.info(
          'Unhandled HTTP request: ${request.method} ${request.requestedUri} ${request.uri}\n${request.headers}',
        );*/

        request.response.statusCode = HttpStatus.forbidden;
        await request.response.close();
      }
    } catch (e) {
      Logger.info('Error: $e');
    }
  }

  void _onMessage(WebSocket socket, String message) {
    try {
      final dynamic json = jsonDecode(message);
      handler.onMessage(socket, JsonMessage.fromJson(json));
    } catch (e) {
      Logger.error(socket, e);
    }
  }

  void _onConnect(WebSocket socket) {
    try {
      handler.onConnect(socket);
    } catch (e) {
      Logger.error(socket, e);
    }
  }

  void _onDisconnect(WebSocket socket) {
    try {
      handler.onDisconnect(socket);
    } catch (e) {
      Logger.error(socket, e);
    }
  }

  void _onError(WebSocket socket, dynamic error) {
    Logger.error(socket, error);
  }

  Future _handleGreeting(HttpRequest request) async {
    Logger.info(
      'HTTP request: ${request.method} ${request.requestedUri}\n${request.headers}',
    );

    request.response.statusCode = HttpStatus.ok;
    request.response.write('Server up and running!');

    await request.response.close();
  }

  Future _handleMatchCreation(HttpRequest request) async {
    Logger.info(
      'HTTP request: ${request.method} ${request.requestedUri}\n${request.headers}',
    );

    final String? apiKey = request.headers[X_API_KEY_HEADER]?[0];

    if (apiKey == environment.apiKey) {
      final String content = await utf8.decodeStream(request);
      final dynamic json = jsonDecode(content);
      final JsonCreateMatch jsonCreateMatch = JsonCreateMatch.fromJson(json);

      if (dispatcher.hasConnection(jsonCreateMatch.matchId)) {
        request.response.statusCode = HttpStatus.conflict;
      } else {
        dispatcher.create(jsonCreateMatch);
        Logger.info('Match created: ${jsonCreateMatch.toJson()}');

        request.response.statusCode = HttpStatus.created;
      }
    } else {
      request.response.statusCode = HttpStatus.unauthorized;
    }

    await request.response.close();
  }

  Future _startTestMatch() async {
    Logger.info('Creating test match...');

    dispatcher.create(
      JsonCreateMatch(
        matchId: 'test-match-id',
        mapId: 'stonewall',
        createdAt: DateTime.now(),
        numberOfPlayers: 2,
        matchType: 'pvp',
        playerIds: ['AAA', 'ZZZ'],
        players: {
          'AAA': const JsonPlayer(
            name: 'Alice',
            deck: [
              UnitType.riflemen,
              UnitType.sniper,
              UnitType.rhino,
              UnitType.pitbull,
              UnitType.orca,
              UnitType.hammerhead,
            ],
          ),
          'ZZZ': const JsonPlayer(
            name: 'Bob',
            deck: [
              UnitType.shocks,
              UnitType.talon,
              UnitType.razorback,
              UnitType.orca,
              UnitType.mohawk,
              UnitType.hammerhead,
            ],
          ),
        },
      ),
    );

    final WebSocket webSocket = await WebSocket.connect(
      'ws://localhost:${environment.port}',
    );
    webSocket.add(
      '{"join": {"matchId":"test-match-id","playerId":"ZZZ"}}',
    );
  }
}
