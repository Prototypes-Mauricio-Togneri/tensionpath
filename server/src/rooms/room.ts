import {Match} from '../domain/match'
import {JsonCreateRoom} from '../json/client_server/json_create_room'
import {JsonMessage} from '../json/server_client/json_message'
import {Socket} from '../server/socket'
import {Logger} from '../utils/logger'

export class Room {
  match: Match | undefined 

  constructor(
    readonly id: string,
    readonly createdAt: Date,
    readonly numberOfPlayers: number,
    readonly matchType: string,
    readonly players: Record<string, string> = {},
    readonly playerIdToSocket: Record<string, Socket> = {},
    readonly socketToPlayerId: Record<string, string> = {},
  ) {}

  static fromJson(json: JsonCreateRoom) {
    return new Room(
      json.roomId,
      new Date(json.createdAt),
      json.numberOfPlayers,
      json.matchType,
    )
  }

  get getMatch(): Match {
    if (this.match) {
      return this.match
    } else {
      throw JsonMessage.error('Match not started')
    }
  }

  public join(playerId: string, socket: Socket) {
    console.log(playerId)
    console.log(socket)
    
    if (!this.match && this.players[playerId]) {
      this.playerIdToSocket[playerId] = socket
      this.socketToPlayerId[socket.id] = playerId

      Logger.log(`Player ${playerId} joined room ${this.id}`, socket)

      if (Object.keys(this.playerIdToSocket).length === this.numberOfPlayers) {
        /*this.match = Match.create(this)

        for (const player of this.match?.players) {
          this.direct(player.id, JsonMessage.update(_match!.json(player))
        }*/
      }
    } else {
      throw JsonMessage.error(`Player ${playerId} cannot join room ${this.id}`)
    }
  }

  public leave(socket: Socket) {
    console.log(socket)
    /*if (webSocketToPlayerId.containsKey(socket)) {
      final String playerId = webSocketToPlayerId[socket]!
      playerIdToWebSocket.remove(playerId)
      webSocketToPlayerId.remove(socket)

      Logger.log(socket, 'Player $playerId left room $id')
    } else {
      throw JsonMessage.error('Cannot find player for socket ${socket.id}')
    }*/
  }

  public increaseMine(socket: Socket) {
    console.log(socket)
    //final String playerId = _getPlayerId(socket)
    //match.increaseMine(playerId)
  }

  /*private getPlayerId(socket: Socket): string {
    final String? playerId = webSocketToPlayerId[socket]

    if (playerId) {
      return playerId
    } else {
      throw JsonMessage.error('Player not in room')
    }
  }*/

  public direct(playerId: string, json: JSON) {
    console.log(playerId)
    console.log(json)
    //final WebSocket socket = playerIdToWebSocket[playerId]!
    //socket.send(json)
  }

  public broadcast(json: JSON) {
    console.log(json)
    //for (final WebSocket socket in webSocketToPlayerId.keys) {
    //  socket.send(json)
    //}
  }

  public update(dt: number) {
    this.match?.update(dt)
  }
}