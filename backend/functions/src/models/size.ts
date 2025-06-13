export interface ISize {
  width: number,
  height: number,
}

export class Size implements ISize {
  width: number
  height: number

  constructor(data: ISize) {
    this.width = data.width
    this.height = data.height
  }
}
