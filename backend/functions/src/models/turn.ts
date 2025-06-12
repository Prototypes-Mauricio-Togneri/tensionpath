import {FirebaseDocument} from '../database/firebase-document'
import {merge} from '../utils/merge'

export interface ITurn {
  turn: number,
  startedAt: Date,
}

export class Turn implements ITurn {
  readonly turn: number
  readonly startedAt: Date

  constructor(data: ITurn) {
    this.turn = data.turn
    this.startedAt = data.startedAt
  }

  public with(data: Partial<ITurn>): Turn {
    return new Turn(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Turn {
    return new Turn(document.data())
  }
}
