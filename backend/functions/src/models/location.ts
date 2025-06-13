export class Location {
  readonly x: number
  readonly y: number

  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }

  public distance(location: Location): number {
    const result = (
      Math.abs(this.x - location.x) +
      Math.abs(this.x + this.y - location.x - location.y) +
      Math.abs(this.y - location.y)
    ) / 2

    return Math.abs(result)
  }
}
