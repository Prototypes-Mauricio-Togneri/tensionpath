export interface IUnit {
  playerId: string,
  level: number,
}

export class Unit implements IUnit {
  playerId: string
  level: number

  constructor(data: IUnit) {
    this.playerId = data.playerId
    this.level = data.level
  }
}

export type BattleUnit = {
  unit: Unit,
  hasMoved: boolean,
}

export type BattleUnits = Record<string, BattleUnit[]>
