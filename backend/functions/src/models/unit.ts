import {FirebaseDocument} from '../database/firebase-document'
import {merge} from '../utils/merge'

export interface IUnit {
  playerId: string,
  level: number,
  hasMoved?: boolean,
}

export class Unit implements IUnit {
  readonly playerId: string
  readonly level: number
  readonly hasMoved?: boolean

  constructor(data: IUnit) {
    this.playerId = data.playerId
    this.level = data.level
    this.hasMoved = data.hasMoved
  }

  public with(data: Partial<IUnit>): Unit {
    return new Unit(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Unit {
    return new Unit(document.data())
  }
}
