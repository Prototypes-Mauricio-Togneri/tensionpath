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
      json.players,
    )
  }

  public get isEmpty(): boolean {
    return (this.match !== undefined) &&
           (Object.keys(this.playerIdToSocket).length === 0) &&
           (Object.keys(this.socketToPlayerId).length === 0)
  }

  public join(playerId: string, socket: Socket) {
    if (!this.match && this.players[playerId]) {
      this.playerIdToSocket[playerId] = socket
      this.socketToPlayerId[socket.id] = playerId

      Logger.log(`Player ${playerId} joined room ${this.id}`, socket)

      if (Object.keys(this.playerIdToSocket).length === this.numberOfPlayers) {
        Logger.log(`Room ${this.id} completed`, socket)

        this.match = Match.create(this)
        this.broadcast(JsonMessage.started())
      }
    } else {
      throw JsonMessage.error(`Player ${playerId} cannot join room ${this.id}`)
    }
  }

  public leave(socket: Socket) {
    const playerId = this.socketToPlayerId[socket.id]

    if (playerId) {
      delete this.playerIdToSocket[playerId]
      delete this.socketToPlayerId[socket.id]

      Logger.log(`Player ${playerId} left room ${this.id}`, socket)
    } else {
      throw JsonMessage.error(`Cannot find player for socket ${socket.id}`)
    }
  }

  public createUnit(socket: Socket) {
    const playerId = this.getPlayerId(socket)
    const match = this.getMatch()
    match.createUnit(playerId)
  }

  public destroyUnit(socket: Socket) {
    const playerId = this.getPlayerId(socket)
    const match = this.getMatch()
    match.destroyUnit(playerId)
  }

  private getPlayerId(socket: Socket): string {
    const playerId = this.socketToPlayerId[socket.id]

    if (playerId) {
      return playerId
    } else {
      throw JsonMessage.error('Player not in room')
    }
  }

  private getMatch(): Match {
    if (this.match) {
      return this.match
    } else {
      throw JsonMessage.error('Match not started')
    }
  }

  public direct(playerId: string, json: JsonMessage) {
    const socket = this.playerIdToSocket[playerId]
    socket.send(json)
  }

  public broadcast(json: JsonMessage) {
    for (const socket of Object.values(this.playerIdToSocket)) {
      socket.send(json)
    }
  }

  public update(dt: number) {
    this.match?.update(dt)
  }
}