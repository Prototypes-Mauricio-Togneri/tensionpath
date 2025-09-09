import {StructureType} from '../types/structure-type'

export interface IStructure {
  type: StructureType,
  playerId?: string,
  platformId?: string,
}

export class Structure implements IStructure {
  type: StructureType
  playerId?: string
  platformId?: string

  constructor(data: IStructure) {
    this.type = data.type
    this.playerId = data.playerId
    this.platformId = data.platformId
  }
}
