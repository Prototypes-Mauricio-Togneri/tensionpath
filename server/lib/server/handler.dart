import 'dart:io';
import 'package:tensionpath/battles/battle_manager.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_increase_attack.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_increase_mine.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_battle.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_launch_units.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/utils/logger.dart';

class Handler {
  final BattleManager battleManager;

  const Handler(this.battleManager);

  void onMessage(WebSocket socket, JsonMessage json) {
    Logger.log(socket, '<<< $json');

    final dynamic message = json.message;

    try {
      if (message is JsonJoinBattle) {
        battleManager.join(
          json: message,
          socket: socket,
        );
      } else if (message is JsonIncreaseMine) {
        battleManager.increaseMine(
          json: message,
          socket: socket,
        );
      } else if (message is JsonIncreaseAttack) {
        battleManager.increaseAttack(
          json: message,
          socket: socket,
        );
      } else if (message is JsonLaunchUnits) {
        battleManager.launchUnits(
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
    battleManager.leave(socket);
  }
}
