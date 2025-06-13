import {ActionType} from '../types/action-type'

export interface IAction {
  type: ActionType,
  playerId: string,
  originX?: number,
  originY?: number,
  targetX: number,
  targetY: number,
  level?: number,
}

export class Action implements IAction {
  type: ActionType
  playerId: string
  originX?: number
  originY?: number
  targetX: number
  targetY: number
  level?: number

  constructor(data: IAction) {
    this.type = data.type
    this.playerId = data.playerId
    this.originX = data.originX
    this.originY = data.originY
    this.targetX = data.targetX
    this.targetY = data.targetY
    this.level = data.level
  }
}
