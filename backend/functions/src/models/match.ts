import * as fs from 'fs'
import {FirebaseDocument} from '../database/firebase-document'
import {MatchStatus} from '../types/match-status'
import {Battlefield} from './battlefield'
import {Config} from './config'
import {Player} from './player'
import {Turn} from './turn'
import {Room} from './room'

export interface IMatch {
  id: string,
  version: number,
  createdAt: Date,
  status: MatchStatus,
  players: Record<string, Player>,
  battlefield: Battlefield,
  config: Config,
  turn: Turn,
}

export class Match implements IMatch {
  id: string
  version: number
  createdAt: Date
  status: MatchStatus
  players: Record<string, Player>
  battlefield: Battlefield
  config: Config
  turn: Turn

  constructor(data: IMatch) {
    this.id = data.id
    this.version = data.version
    this.createdAt = data.createdAt
    this.status = data.status
    this.players = data.players
    this.battlefield = data.battlefield
    this.config = data.config
    this.turn = data.turn
  }

  public static parse(document: FirebaseDocument): Match {
    return new Match(document.data())
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

    for (const [playerId, player] of Object.entries(match.players)) {
      player.name = params.room.playersMap[playerId]!
    }

    return match
  }
}
