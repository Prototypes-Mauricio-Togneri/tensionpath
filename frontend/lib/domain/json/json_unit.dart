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

  @JsonKey(name: 'deploymentCost')
  final int deploymentCost;

  @JsonKey(name: 'movementCost')
  final int movementCost;

  @JsonKey(name: 'health')
  final int health;

  @JsonKey(name: 'maxHealth')
  final int maxHealth;

  @JsonKey(name: 'visibilityRange')
  final int visibilityRange;

  @JsonKey(name: 'movementRange')
  final int movementRange;

  @JsonKey(name: 'attackRange')
  final int attackRange;

  @JsonKey(name: 'moves')
  final int moves;

  @JsonKey(name: 'player')
  final String player;

  const JsonUnit({
    required this.type,
    required this.deploymentCost,
    required this.movementCost,
    required this.health,
    required this.maxHealth,
    required this.visibilityRange,
    required this.movementRange,
    required this.attackRange,
    required this.moves,
    required this.player,
  });

  Unit object(List<Player> players) {
    final Player unitPlayer = Player.playerById(id: player, players: players)!;

    switch (type) {
      case UnitType.rifle_squad:
        return UnitRifleSquad(health: health, moves: moves, player: unitPlayer);
      case UnitType.sniper:
        return UnitSniper(health: health, moves: moves, player: unitPlayer);
      case UnitType.humvee:
        return UnitHumvee(health: health, moves: moves, player: unitPlayer);
      case UnitType.tank:
        return UnitTank(health: health, moves: moves, player: unitPlayer);
      case UnitType.artillery:
        return UnitArtillery(health: health, moves: moves, player: unitPlayer);
      case UnitType.helicopter:
        return UnitHelicopter(health: health, moves: moves, player: unitPlayer);
    }
  }

  factory JsonUnit.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitToJson(this);
}
