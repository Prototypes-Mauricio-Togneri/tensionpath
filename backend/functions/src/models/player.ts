import {FirebaseDocument} from '../database/firebase-document'
import {PlayerStatus} from '../types/player-status'
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
  id: string
  name: string
  baseHealth: number
  resources: number
  status: PlayerStatus
  turnEndedAt?: Date
  actions: Action[]

  constructor(data: IPlayer) {
    this.id = data.id
    this.name = data.name
    this.baseHealth = data.baseHealth
    this.resources = data.resources
    this.status = data.status
    this.turnEndedAt = data.turnEndedAt
    this.actions = data.actions
  }

  public static parse(document: FirebaseDocument): Player {
    return new Player(document.data())
  }
}
