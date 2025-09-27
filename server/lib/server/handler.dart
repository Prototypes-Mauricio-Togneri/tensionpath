import 'dart:io';
import 'package:tensionpath/domain/json/messages/client_server/json_attack_unit.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_deploy_unit.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_move_unit.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_unit_action.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/server/dispatcher.dart';
import 'package:tensionpath/utils/logger.dart';

class Handler {
  final Dispatcher dispatcher;

  const Handler(this.dispatcher);

  void onMessage(WebSocket socket, JsonMessage json) {
    Logger.log(socket, '<<< $json');

    try {
      final dynamic message = json.message;

      if (message is JsonJoinMatch) {
        dispatcher.join(
          json: message,
          socket: socket,
        );
      } else if (message is JsonDeployUnit) {
        dispatcher.deployUnit(
          json: message,
          socket: socket,
        );
      } else if (message is JsonMoveUnit) {
        dispatcher.moveUnit(
          json: message,
          socket: socket,
        );
      } else if (message is JsonAttackUnit) {
        dispatcher.attackUnit(
          json: message,
          socket: socket,
        );
      } else if (message is JsonUnitAction) {
        dispatcher.unitAction(
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
    dispatcher.leave(socket);
  }
}
