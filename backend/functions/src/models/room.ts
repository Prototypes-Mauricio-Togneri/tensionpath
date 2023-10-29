import {FirebaseDocument} from '../database/firebase-document'
import {RoomStatus} from '../types/room-status'
import {merge} from '../utils/merge'

export interface IRoom {
  id: string
  createdAt: Date,
  numberOfPlayers: number
  status: RoomStatus
  playerIds: string[]
}

export class Room implements IRoom {
  readonly id: string
  readonly createdAt: Date
  readonly numberOfPlayers: number
  readonly status: RoomStatus
  readonly playerIds: string[]

  constructor(data: IRoom) {
    this.id = data.id
    this.createdAt = data.createdAt
    this.numberOfPlayers = data.numberOfPlayers
    this.status = data.status
    this.playerIds = data.playerIds
  }

  public with(data: Partial<IRoom>): Room {
    return new Room(merge(this, data))
  }

  public join(playerId: string): Room {
    const playerInRoom = this.playerIds.includes(playerId)
    const roomFull = !playerInRoom && (this.numberOfPlayers === (this.playerIds.length + 1))

    const newStatus = roomFull ? RoomStatus.closed : RoomStatus.open
    const newPlayerIds = this.playerIds

    if (!playerInRoom) {
      newPlayerIds.push(playerId)
    }

    return this.with({
      status: newStatus,
      playerIds: newPlayerIds,
    })
  }

  public static create(params: {
    playerId: string,
    numberOfPlayers: number,
  }): Room {
    return new Room({
      id: '',
      createdAt: new Date(),
      numberOfPlayers: params.numberOfPlayers,
      status: RoomStatus.open,
      playerIds: [params.playerId],
    })
  }

  public static parse(document: FirebaseDocument): Room {
    return new Room(document.data())
  }
}
