import {FirebaseDocument} from '../database/firebase-document'
import {StructureType} from '../types/structure-type'
import {merge} from '../utils/merge'

export interface IStructure {
  type: StructureType,
  playerId?: string,
  platformId?: string,
}

export class Structure implements IStructure {
  readonly type: StructureType
  readonly playerId?: string
  readonly platformId?: string

  constructor(data: IStructure) {
    this.type = data.type
    this.playerId = data.playerId
    this.platformId = data.platformId
  }

  public with(data: Partial<IStructure>): Structure {
    return new Structure(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Structure {
    return new Structure(document.data())
  }
}
