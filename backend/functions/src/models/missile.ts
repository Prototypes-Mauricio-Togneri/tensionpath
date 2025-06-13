export interface IMissile {
  charge: number,
  maxCharge: number,
  bufferCharge: number,
  numberOfPlatforms: number,
  platforms: Record<string, string | undefined>,
  owner?: string,
}

export class Missile implements IMissile {
  charge: number
  maxCharge: number
  bufferCharge: number
  numberOfPlatforms: number
  platforms: Record<string, string | undefined>
  owner?: string

  constructor(data: IMissile) {
    this.charge = data.charge
    this.maxCharge = data.maxCharge
    this.bufferCharge = data.bufferCharge
    this.numberOfPlatforms = data.numberOfPlatforms
    this.platforms = data.platforms
    this.owner = data.owner
  }
}
