export interface IConfig {
  popcap: number,
  baseMaxHealth: number,
  resourcesPerPatch: number,
  resourcesPerTurn: number,
  resourcesPerSecond: number,
  defenseFactor: number,
  typeFactor: number,
}

export class Config implements IConfig {
  popcap: number
  baseMaxHealth: number
  resourcesPerPatch: number
  resourcesPerTurn: number
  resourcesPerSecond: number
  defenseFactor: number
  typeFactor: number

  constructor(data: IConfig) {
    this.popcap = data.popcap
    this.baseMaxHealth = data.baseMaxHealth
    this.resourcesPerPatch = data.resourcesPerPatch
    this.resourcesPerTurn = data.resourcesPerTurn
    this.resourcesPerSecond = data.resourcesPerSecond
    this.defenseFactor = data.defenseFactor
    this.typeFactor = data.typeFactor
  }
}
