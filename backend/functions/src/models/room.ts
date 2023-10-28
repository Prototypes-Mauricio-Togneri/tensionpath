interface TRoom {
  id: string
  numberOfPlayers: number
}

export default class Room implements TRoom {
  readonly id: string
  readonly numberOfPlayers: number

  constructor(data: TRoom) {
    this.id = data.id
    this.numberOfPlayers = data.numberOfPlayers
  }

  public with(params: {
    id?: string,
    numberOfPlayers?: number,
  }): Room {
    return new Room({
      ...this,
      ...params.id && {id: params.id},
      ...params.numberOfPlayers && {numberOfPlayers: params.numberOfPlayers},
    })
  }
}
