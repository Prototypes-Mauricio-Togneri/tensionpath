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

export default class Room implements IRoom {
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

  public static parse(document: FirebaseDocument): Room {
    return new Room(document.data())
  }
}
