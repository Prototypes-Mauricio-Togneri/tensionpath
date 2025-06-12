import {FirebaseDocument} from '../database/firebase-document'
import {merge} from '../utils/merge'

export interface IConfig {
  popcap: number,
  baseMaxHealth: number,
  resourcesPerPatch: number,
  resourcesPerTurn: number,
  resourcesPerSecond: number,
  defenseFactor: number,
}

export class Config implements IConfig {
  readonly popcap: number
  readonly baseMaxHealth: number
  readonly resourcesPerPatch: number
  readonly resourcesPerTurn: number
  readonly resourcesPerSecond: number
  readonly defenseFactor: number

  constructor(data: IConfig) {
    this.popcap = data.popcap
    this.baseMaxHealth = data.baseMaxHealth
    this.resourcesPerPatch = data.resourcesPerPatch
    this.resourcesPerTurn = data.resourcesPerTurn
    this.resourcesPerSecond = data.resourcesPerSecond
    this.defenseFactor = data.defenseFactor
  }

  public with(data: Partial<IConfig>): Config {
    return new Config(merge(this, data))
  }

  public static parse(document: FirebaseDocument): Config {
    return new Config(document.data())
  }
}
