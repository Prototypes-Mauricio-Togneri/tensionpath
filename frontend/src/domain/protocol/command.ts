import type {Position} from '@/domain/entities/position'
import type {UnitId} from '@/domain/types/ids'
import type {UnitType} from '@/domain/types/unit_type'

/**
 * A request from a client to the authoritative engine, one variant per action
 * in docs/specs.md.
 * Commands carry no player id: the engine attributes each one to the
 * connection it arrived on, so a client cannot act for another player.
 */
export type Command =
  | DeployUnitCommand
  | StopUnitCommand
  | ResumeUnitCommand
  | SwitchTargetCommand
  | SwitchLaneCommand
  | ActivateAbilityCommand

export type DeployUnitCommand = {
  kind: 'deploy_unit'
  unitType: UnitType
  position: Position
}

export type StopUnitCommand = {
  kind: 'stop_unit'
  unitId: UnitId
}

export type ResumeUnitCommand = {
  kind: 'resume_unit'
  unitId: UnitId
}

export type SwitchTargetCommand = {
  kind: 'switch_target'
  unitId: UnitId
  targetUnitId: UnitId | null
}

export type SwitchLaneCommand = {
  kind: 'switch_lane'
  unitId: UnitId
  lane: number
}

export type ActivateAbilityCommand = {
  kind: 'activate_ability'
  unitId: UnitId
}
