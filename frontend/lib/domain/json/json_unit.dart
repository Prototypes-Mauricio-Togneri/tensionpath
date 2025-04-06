import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/entities/units/unit_artillery.dart';
import 'package:tensionpath/domain/entities/units/unit_helicopter.dart';
import 'package:tensionpath/domain/entities/units/unit_humvee.dart';
import 'package:tensionpath/domain/entities/units/unit_rifle_squad.dart';
import 'package:tensionpath/domain/entities/units/unit_sniper.dart';
import 'package:tensionpath/domain/entities/units/unit_tank.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_unit.g.dart';

@JsonSerializable()
class JsonUnit {
  @JsonKey(name: 'type')
  final UnitType type;

  @JsonKey(name: 'cost')
  final int cost;

  @JsonKey(name: 'maxHealth')
  final int maxHealth;

  @JsonKey(name: 'health')
  final int health;

  @JsonKey(name: 'attackRange')
  final int attackRange;

  @JsonKey(name: 'movementRange')
  final int movementRange;

  @JsonKey(name: 'visibilityRange')
  final int visibilityRange;

  @JsonKey(name: 'attack')
  final int attack;

  @JsonKey(name: 'player')
  final String player;

  const JsonUnit({
    required this.type,
    required this.cost,
    required this.maxHealth,
    required this.health,
    required this.attackRange,
    required this.movementRange,
    required this.visibilityRange,
    required this.attack,
    required this.player,
  });

  Unit object(List<Player> players) {
    final Player unitPlayer = Player.playerById(id: player, players: players)!;

    switch (type) {
      case UnitType.rifle_squad:
        return UnitRifleSquad(
          cost: cost,
          maxHealth: health,
          attackRange: attackRange,
          movementRange: movementRange,
          visibilityRange: visibilityRange,
          attack: attack,
          player: unitPlayer,
        );
      case UnitType.sniper:
        return UnitSniper(
          cost: cost,
          maxHealth: health,
          attackRange: attackRange,
          movementRange: movementRange,
          visibilityRange: visibilityRange,
          attack: attack,
          player: unitPlayer,
        );
      case UnitType.humvee:
        return UnitHumvee(
          cost: cost,
          maxHealth: health,
          attackRange: attackRange,
          movementRange: movementRange,
          visibilityRange: visibilityRange,
          attack: attack,
          player: unitPlayer,
        );
      case UnitType.tank:
        return UnitTank(
          cost: cost,
          maxHealth: health,
          attackRange: attackRange,
          movementRange: movementRange,
          visibilityRange: visibilityRange,
          attack: attack,
          player: unitPlayer,
        );
      case UnitType.artillery:
        return UnitArtillery(
          cost: cost,
          maxHealth: health,
          attackRange: attackRange,
          movementRange: movementRange,
          visibilityRange: visibilityRange,
          attack: attack,
          player: unitPlayer,
        );
      case UnitType.helicopter:
        return UnitHelicopter(
          cost: cost,
          maxHealth: health,
          attackRange: attackRange,
          movementRange: movementRange,
          visibilityRange: visibilityRange,
          attack: attack,
          player: unitPlayer,
        );
    }
  }

  factory JsonUnit.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitToJson(this);
}
