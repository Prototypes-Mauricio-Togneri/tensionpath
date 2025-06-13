import {PlayerStatus} from '../types/player-status'
import {Action} from './action'

export interface IPlayer {
  id: string,
  name: string,
  userId: string,
  baseHealth: number,
  resources: number,
  status: PlayerStatus,
  turnEndedAt?: Date,
  actions: Action[],
}

export class Player implements IPlayer {
  id: string
  name: string
  userId: string
  baseHealth: number
  resources: number
  status: PlayerStatus
  turnEndedAt?: Date
  actions: Action[]

  constructor(data: IPlayer) {
    this.id = data.id
    this.name = data.name
    this.userId = data.userId
    this.baseHealth = data.baseHealth
    this.resources = data.resources
    this.status = data.status
    this.turnEndedAt = data.turnEndedAt
    this.actions = data.actions
  }
}
