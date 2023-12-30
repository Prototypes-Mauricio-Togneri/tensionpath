import {Room} from '../rooms/room'
import {Player} from './player'

export class Match {
  constructor(
    readonly room: Room,
    readonly players: Record<string, Player>,
  ) {}

  static create(room: Room) {
    const players: Record<string, Player> = {}

    for (const [playerId, playerName] of Object.entries(room.players)) {
      players[playerId] = new Player(playerId, playerName)
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