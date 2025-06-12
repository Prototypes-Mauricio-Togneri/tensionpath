import {FirebaseDocument} from '../database/firebase-document'
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
  id: string
  size: Size
  missile: Missile
  nodes: Node[]

  constructor(data: IBattlefield) {
    this.id = data.id
    this.size = data.size
    this.missile = data.missile
    this.nodes = data.nodes
  }

  public static parse(document: FirebaseDocument): Battlefield {
    return new Battlefield(document.data())
  }
}
