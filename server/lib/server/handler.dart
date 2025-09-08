import 'dart:io';
import 'package:tensionpath/domain/json/messages/client_server/json_increase_attack.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_increase_mine.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_room.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_launch_units.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/rooms/rooms_manager.dart';
import 'package:tensionpath/utils/logger.dart';

class Handler {
  final RoomsManager roomsManager;

  const Handler(this.roomsManager);

  void onMessage(WebSocket socket, JsonMessage json) {
    Logger.log(socket, '<<< $json');

    final dynamic message = json.message;

    try {
      if (message is JsonJoinRoom) {
        roomsManager.join(
          json: message,
          socket: socket,
        );
      } else if (message is JsonIncreaseMine) {
        roomsManager.increaseMine(
          json: message,
          socket: socket,
        );
      } else if (message is JsonIncreaseAttack) {
        roomsManager.increaseAttack(
          json: message,
          socket: socket,
        );
      } else if (message is JsonLaunchUnits) {
        roomsManager.launchUnits(
          json: message,
          socket: socket,
        );
      }
    } on JsonMessage catch (e) {
      socket.send(e);
    } catch (e) {
      socket.send(JsonMessage.error('Unknown error $e'));
    }
  }

  void onConnect(WebSocket socket) {
    try {
      Logger.log(socket, 'Connected');
      socket.send(JsonMessage.welcome());
    } catch (e) {
      Logger.error(e);
    }
  }

  void onDisconnect(WebSocket socket) {
    try {
      Logger.log(socket, 'Disconnected');
      roomsManager.leave(socket);
    } catch (e) {
      Logger.error(e);
    }
  }

  void onError(WebSocket socket, dynamic error) {
    try {
      Logger.log(socket, 'Error: $error');
    } catch (e) {
      Logger.error(e);
    }
  }
}
