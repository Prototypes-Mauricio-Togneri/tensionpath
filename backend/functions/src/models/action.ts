import {FirebaseDocument} from '../database/firebase-document'
import {ActionType} from '../types/action-type'
import {merge} from '../utils/merge'

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
  readonly type: ActionType
  readonly playerId: string
  readonly originX?: number
  readonly originY?: number
  readonly targetX: number
  readonly targetY: number
  readonly level?: number

  constructor(data: IAction) {
    this.type = data.type
    this.playerId = data.playerId
    this.originX = data.originX
    this.originY = data.originY
    this.targetX = data.targetX
    this.targetY = data.targetY
    this.level = data.level
  }

  public with(data: Partial<IAction>): Action {
    return new Action(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Action {
    return new Action(document.data())
  }
}
