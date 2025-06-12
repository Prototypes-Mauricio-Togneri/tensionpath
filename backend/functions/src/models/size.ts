import {FirebaseDocument} from '../database/firebase-document'
import {merge} from '../utils/merge'

export interface ISize {
  width: number,
  height: number,
}

export class Size implements ISize {
  readonly width: number
  readonly height: number

  constructor(data: ISize) {
    this.width = data.width
    this.height = data.height
  }

  public with(data: Partial<ISize>): Size {
    return new Size(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Size {
    return new Size(document.data())
  }
}
