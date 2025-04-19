import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_unit.g.dart';

@JsonSerializable()
class JsonUnit {
  @JsonKey(name: 'type')
  final UnitType type;

  @JsonKey(name: 'health')
  final int health;

  @JsonKey(name: 'remainingMoves')
  final int remainingMoves;

  @JsonKey(name: 'player')
  final String player;

  const JsonUnit({
    required this.type,
    required this.health,
    required this.remainingMoves,
    required this.player,
  });

  Unit object({required Node node, required List<Player> players}) =>
      Unit.create(
        unitType: type,
        node: node,
        player: Player.playerById(id: player, players: players)!,
        health: health,
        remainingMoves: remainingMoves,
      );

  factory JsonUnit.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitToJson(this);
}
