import {FirebaseDocument} from '../database/firebase-document'

export interface ITurn {
  turn: number,
  startedAt: Date,
}

export class Turn implements ITurn {
  turn: number
  startedAt: Date

  constructor(data: ITurn) {
    this.turn = data.turn
    this.startedAt = data.startedAt
  }

  public static parse(document: FirebaseDocument): Turn {
    return new Turn(document.data())
  }
}
