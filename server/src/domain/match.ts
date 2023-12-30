import {Room} from '../rooms/room'
import {Player} from './player'

export class Match {
  constructor(
    readonly room: Room,
    readonly players: Record<string, Player>,
  ) {}

  static create(room: Room) {
    const players: Record<string, Player> = {}

    for (const entry of Object.entries(room.players)) {
      players[entry[0]] = new Player(entry[0], entry[1])
  }

    return new Match(room, players)
  }
  
  public createUnit(playerId: string) {
    console.log(playerId)
  }

  public update(dt: number) {
    console.log(dt)
  }
}