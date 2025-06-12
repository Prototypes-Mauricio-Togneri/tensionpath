import {FirebaseDocument} from '../database/firebase-document'
import {MatchStatus} from '../types/match-status'
import {merge} from '../utils/merge'
import {Battlefield} from './battlefield'
import {Config} from './config'
import {Player} from './player'
import {Turn} from './turn'

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
  readonly id: string
  readonly version: number
  readonly createdAt: Date
  readonly status: MatchStatus
  readonly players: Record<string, Player>
  readonly battlefield: Battlefield
  readonly config: Config
  readonly turn: Turn

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

  public with(data: Partial<IMatch>): Match {
    return new Match(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Match {
    return new Match(document.data())
  }
}
