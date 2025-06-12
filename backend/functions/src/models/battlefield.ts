import {FirebaseDocument} from '../database/firebase-document'
import {merge} from '../utils/merge'
import {Missile} from './missile'
import {Node} from './node'
import {Size} from './size'

export interface IBattlefield {
  id: string,
  size: Size,
  missile: Missile,
  nodes: Node[],
}

export class Battlefield implements IBattlefield {
  readonly id: string
  readonly size: Size
  readonly missile: Missile
  readonly nodes: Node[]

  constructor(data: IBattlefield) {
    this.id = data.id
    this.size = data.size
    this.missile = data.missile
    this.nodes = data.nodes
  }

  public with(data: Partial<IBattlefield>): Battlefield {
    return new Battlefield(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Battlefield {
    return new Battlefield(document.data())
  }
}
