import {FirebaseDocument} from '../database/firebase-document'
import {PlayerStatus} from '../types/player-status'
import {merge} from '../utils/merge'
import {Action} from './action'

export interface IPlayer {
  id: string,
  name: string,
  baseHealth: number,
  resources: number,
  status: PlayerStatus,
  turnEndedAt?: Date,
  actions: Action[],
}

export class Player implements IPlayer {
  readonly id: string
  readonly name: string
  readonly baseHealth: number
  readonly resources: number
  readonly status: PlayerStatus
  readonly turnEndedAt?: Date
  readonly actions: Action[]

  constructor(data: IPlayer) {
    this.id = data.id
    this.name = data.name
    this.baseHealth = data.baseHealth
    this.resources = data.resources
    this.status = data.status
    this.turnEndedAt = data.turnEndedAt
    this.actions = data.actions
  }

  public with(data: Partial<IPlayer>): Player {
    return new Player(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Player {
    return new Player(document.data())
  }
}
