import {FirebaseDocument} from '../database/firebase-document'
import {RoomStatus} from '../types/room-status'
import {RoomVisibility} from '../types/room-visibility'

export interface IRoom {
  id: string,
  version: number,
  createdAt: Date,
  numberOfPlayers: number,
  visibility: RoomVisibility,
  status: RoomStatus,
  matchType: string,
  userIds: string[],
  users: Record<string, string>,
  matchId?: string,
}

export class Room implements IRoom {
  id: string
  version: number
  createdAt: Date
  numberOfPlayers: number
  visibility: RoomVisibility
  status: RoomStatus
  matchType: string
  userIds: string[]
  users: Record<string, string>
  matchId?: string

  constructor(data: IRoom) {
    this.id = data.id
    this.version = data.version
    this.createdAt = data.createdAt
    this.numberOfPlayers = data.numberOfPlayers
    this.visibility = data.visibility
    this.status = data.status
    this.matchType = data.matchType
    this.userIds = data.userIds
    this.users = data.users
    this.matchId = data.matchId
  }

  public get isFull(): boolean {
    return this.userIds.length >= this.numberOfPlayers
  }

  public hasUser(userId: string): boolean {
    return this.userIds.includes(userId)
  }

  public join(params: {
    userId: string,
    name: string
  }): Room {
    this.userIds = [
      ...this.userIds,
      params.userId,
    ]
    this.users = {
      ...this.users,
      [params.userId]: params.name,
    }
    this.status = this.isFull ? RoomStatus.closed : RoomStatus.open

    return this
  }

  public leave(userId: string): Room {
    this.userIds = this.userIds.filter((p) => p !== userId)
    delete this.users[userId]

    return this
  }

  public static create(params: {
    userId: string,
    name: string,
    version: number,
    matchType: string,
    numberOfPlayers: number,
    visibility: RoomVisibility,
  }): Room {
    return new Room({
      id: '',
      version: params.version,
      createdAt: new Date(),
      numberOfPlayers: params.numberOfPlayers,
      visibility: params.visibility,
      status: RoomStatus.open,
      matchType: params.matchType,
      userIds: [params.userId],
      users: {
        [params.userId]: params.name,
      },
    })
  }

  public static parse(document: FirebaseDocument): Room {
    return new Room(document.data())
  }
}
