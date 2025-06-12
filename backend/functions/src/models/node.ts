import {FirebaseDocument} from '../database/firebase-document'
import {NodeType} from '../types/node-type'
import {merge} from '../utils/merge'
import {Structure} from './structure'
import {Unit} from './unit'

export interface INode {
  x: number,
  y: number,
  type: NodeType,
  unit?: Unit,
  structure?: Structure,
  temporaryUnits?: Unit[],
}

export class Node implements INode {
  readonly x: number
  readonly y: number
  readonly type: NodeType
  readonly unit?: Unit
  readonly structure?: Structure
  readonly temporaryUnits?: Unit[]

  constructor(data: INode) {
    this.x = data.x
    this.y = data.y
    this.type = data.type
    this.unit = data.unit
    this.structure = data.structure
    this.temporaryUnits = data.temporaryUnits
  }

  public with(data: Partial<INode>): Node {
    return new Node(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Node {
    return new Node(document.data())
  }
}
