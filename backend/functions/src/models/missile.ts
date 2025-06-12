import {FirebaseDocument} from '../database/firebase-document'
import {merge} from '../utils/merge'

export interface IMissile {
  charge: number,
  maxCharge: number,
  bufferCharge: number,
  numberOfPlatforms: number,
  platforms: Record<string, string | null>,
  owner?: string,
}

export class Missile implements IMissile {
  readonly charge: number
  readonly maxCharge: number
  readonly bufferCharge: number
  readonly numberOfPlatforms: number
  readonly platforms: Record<string, string | null>
  readonly owner?: string

  constructor(data: IMissile) {
    this.charge = data.charge
    this.maxCharge = data.maxCharge
    this.bufferCharge = data.bufferCharge
    this.numberOfPlatforms = data.numberOfPlatforms
    this.platforms = data.platforms
    this.owner = data.owner
  }

  public with(data: Partial<IMissile>): Missile {
    return new Missile(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Missile {
    return new Missile(document.data())
  }
}
