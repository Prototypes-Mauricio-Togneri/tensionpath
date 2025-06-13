import {NodeType} from '../types/node-type'
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
  x: number
  y: number
  type: NodeType
  unit?: Unit
  structure?: Structure
  temporaryUnits?: Unit[]

  constructor(data: INode) {
    this.x = data.x
    this.y = data.y
    this.type = data.type
    this.unit = data.unit
    this.structure = data.structure
    this.temporaryUnits = data.temporaryUnits
  }
}

export type Nodes = Record<string, Node>
