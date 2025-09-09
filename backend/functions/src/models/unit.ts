import {UnitType} from '../types/unit-type'

export interface IUnit {
  playerId: string,
  level: number,
  type: UnitType,
}

export class Unit implements IUnit {
  playerId: string
  level: number
  type: UnitType

  constructor(data: IUnit) {
    this.playerId = data.playerId
    this.level = data.level
    this.type = data.type
  }
}

export type BattleUnit = {
  unit: Unit,
  hasMoved: boolean,
}

export type BattleUnits = Record<string, BattleUnit[]>
