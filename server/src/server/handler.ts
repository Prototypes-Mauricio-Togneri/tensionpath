import {WebSocket} from 'ws'
import {RoomsManager} from '../rooms/rooms-manager'

export class Handler {
  constructor(
    readonly roomsManager: RoomsManager,
  ) {}

  public onMessage(socket: WebSocket, json: JSON) {
    /*Logger.log(socket, '<<< $json');

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
    }*/
  }

  public onConnect(socket: WebSocket) {
    try {
      //Logger.log(socket, 'Connected');
      //socket.send(JsonMessage.welcome());
    } catch (e) {
      //Logger.error(e);
    }
  }

  public onDisconnect(socket: WebSocket) {
    try {
      //Logger.log(socket, 'Disconnected');
      //roomsManager.leave(socket);
    } catch (e) {
      //Logger.error(e);
    }
  }

  public onError(socket: WebSocket, error: unknown) {
    try {
      //Logger.log(socket, 'Error: $error');
    } catch (e) {
      //Logger.error(e);
    }
  }
}
