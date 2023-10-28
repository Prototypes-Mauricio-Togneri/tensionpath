import {FirebaseDocument} from '../database/firebase-document'

export interface IRoom {
  id: string
  numberOfPlayers: number
}

export default class Room implements IRoom {
  readonly id: string
  readonly numberOfPlayers: number

  constructor(data: IRoom) {
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

  public static parse(document: FirebaseDocument): Room {
    return new Room(document.data())
  }
}
