import * as fs from 'fs'
import {FirebaseDocument} from '../database/firebase-document'
import {MatchStatus} from '../types/match-status'
import {Battlefield} from './battlefield'
import {Config} from './config'
import {Player, Players} from './player'
import {Turn} from './turn'
import {Room} from './room'

export interface IMatch {
  id: string,
  version: number,
  createdAt: Date,
  status: MatchStatus,
  players: Players,
  battlefield: Battlefield,
  config: Config,
  turn: Turn,
  room: Room,
}

export class Match implements IMatch {
  id: string
  version: number
  createdAt: Date
  status: MatchStatus
  players: Players
  battlefield: Battlefield
  config: Config
  turn: Turn
  room: Room

  constructor(data: IMatch) {
    this.id = data.id
    this.version = data.version
    this.createdAt = data.createdAt
    this.status = data.status
    this.players = data.players
    this.battlefield = data.battlefield
    this.config = data.config
    this.turn = data.turn
    this.room = data.room
  }

  public static parse(document: FirebaseDocument): Match {
    return new Match(document.data())
  }

  public playerByUserId(userId: string): Player | undefined {
    for (const player of Object.values(this.players)) {
      if (player.userId === userId) {
        return player
      }
    }

    return undefined
  }

  public static create(params: {
    mapId: string,
    room: Room,
  }): Match {
    const data = fs.readFileSync(`static/maps/${params.mapId}.json`, 'utf8')
    const json = JSON.parse(data)
    const match = new Match(json)
    match.createdAt = new Date()
    match.turn.startedAt = new Date()
    match.room = params.room

    for (let i = 0; i < params.room.userIds.length; i++) {
      const playerId = (i + 1).toString()
      const userId = params.room.userIds[i]
      const name = params.room.users[userId]

      const player = match.players[playerId]
      player.name = name
      player.userId = userId
    }

    return match
  }
}
