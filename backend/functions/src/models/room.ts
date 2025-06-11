import {FirebaseDocument} from '../database/firebase-document'
import {RoomStatus} from '../types/room-status'
import {RoomVisibility} from '../types/room-visibility'
import {merge} from '../utils/merge'

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
  readonly id: string
  readonly version: number
  readonly createdAt: Date
  readonly numberOfPlayers: number
  readonly visibility: RoomVisibility
  readonly status: RoomStatus
  readonly matchType: string
  readonly userIds: string[]
  readonly users: Record<string, string>
  readonly matchId?: string

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

  public get joinedUsers(): number {
    return this.userIds.length
  }

  public with(data: Partial<IRoom>): Room {
    return new Room(merge(this, data))
  }

  public hasUser(userId: string): boolean {
    return this.userIds.includes(userId)
  }

  public join(params: {
    userId: string,
    name: string
  }): Room {
    const newUserIds = [
      ...this.userIds,
      params.userId,
    ]
    const newUsers = {
      ...this.users,
      [params.userId]: params.name,
    }
    const roomFull = this.numberOfPlayers === newUserIds.length
    const newStatus = roomFull ? RoomStatus.closed : RoomStatus.open

    return this.with({
      status: newStatus,
      userIds: newUserIds,
      users: newUsers,
    })
  }

  public leave(userId: string): Room {
    const newUserIds = this.userIds.filter((p) => p !== userId)
    const newUsers: Record<string, string> = {}

    for (const mapUserId of Object.keys(this.users)) {
      if (mapUserId !== userId) {
        newUsers[mapUserId] = this.users[mapUserId]
      }
    }

    return this.with({
      userIds: newUserIds,
      users: newUsers,
    })
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
      createdAt: new Date(),
      version: params.version,
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
