import 'dart:io';
import 'package:tensionpath/domain/json/messages/client_server/json_join_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_launch_units.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/matches/match_manager.dart';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/utils/logger.dart';

class Handler {
  final MatchManager matchManager;

  const Handler(this.matchManager);

  void onMessage(WebSocket socket, JsonMessage json) {
    Logger.log(socket, '<<< $json');

    final dynamic message = json.message;

    try {
      if (message is JsonJoinMatch) {
        matchManager.join(
          json: message,
          socket: socket,
        );
      } else if (message is JsonLaunchUnits) {
        matchManager.launchUnits(
          json: message,
          socket: socket,
        );
      } else {
        throw JsonMessage.error('Unknown message type $message');
      }
    } on JsonMessage catch (e) {
      socket.send(e);
    } catch (e) {
      Logger.error(socket, e);
      socket.send(JsonMessage.error('Unknown error $e'));
    }
  }

  void onConnect(WebSocket socket) {
    Logger.log(socket, 'Connected');
    socket.send(JsonMessage.welcome());
  }

  void onDisconnect(WebSocket socket) {
    Logger.log(socket, 'Disconnected');
    matchManager.leave(socket);
  }
}
