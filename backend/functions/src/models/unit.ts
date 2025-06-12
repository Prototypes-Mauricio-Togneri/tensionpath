import {FirebaseDocument} from '../database/firebase-document'

export interface IUnit {
  playerId: string,
  level: number,
  hasMoved?: boolean,
}

export class Unit implements IUnit {
  playerId: string
  level: number
  hasMoved?: boolean

  constructor(data: IUnit) {
    this.playerId = data.playerId
    this.level = data.level
    this.hasMoved = data.hasMoved
  }

  public static parse(document: FirebaseDocument): Unit {
    return new Unit(document.data())
  }
}
