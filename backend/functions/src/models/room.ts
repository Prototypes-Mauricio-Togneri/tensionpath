import {FirebaseDocument} from '../database/firebase-document'
import {RoomStatus} from '../types/room-status'

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

  public with(params: Partial<IRoom>): Room {
    return new Room({
      ...this,
      ...params.id && {id: params.id},
      ...params.numberOfPlayers && {numberOfPlayers: params.numberOfPlayers},
    })
  }

  public static parse(document: FirebaseDocument): Room {
    return new Room(document.data())
  }
}
