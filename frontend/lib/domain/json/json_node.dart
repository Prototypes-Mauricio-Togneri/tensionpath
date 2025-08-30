import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_launcher.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_pad.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_position.dart';
import 'package:tensionpath/domain/json/json_resources.dart';

part 'json_node.g.dart';

@JsonSerializable()
class JsonNode {
  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'resources')
  final JsonResources? resources;

  @JsonKey(name: 'missile')
  final JsonMissile? missile;

  @JsonKey(name: 'pad')
  final JsonPad? pad;

  @JsonKey(name: 'launcher')
  final JsonLauncher? launcher;

  const JsonNode({
    required this.position,
    required this.resources,
    required this.missile,
    required this.pad,
    required this.launcher,
  });

  String get id => position.id;

  bool get hasStructure =>
      (missile != null) || (pad != null) || (launcher != null);

  bool get isLauncher => launcher != null;

  bool isDeploymentTarget(JsonPlayer self) =>
      isLauncher && (launcher!.playerId == self.id);

  /*bool isMovementTarget(Unit unit) {
    final bool isAllowedTarget =
        (_structure == null) || _structure!.type.canMoveUnit;
    final bool hasMoves = unit.remainingMoves > 0;
    const bool inDistance = true;
    //distance(unit) <= unit.movementRange;

    return isAllowedTarget && hasMoves && inDistance;
  }*/

  /*bool isAttackUnitTarget(Unit unit) {
    /*final bool hasAttacks = unit.remainingAttacks > 0;
    final bool canAttack = hasUnit && unit.damageTo(_unit!) > 0;
    final bool inDistance =
        distance(unit) >= unit.minAttackRange &&
        distance(unit) <= unit.maxAttackRange;*/

    return false;
  }*/

  /*bool isAttackBaseTarget(Unit unit) {
    final bool hasOpponentBase =
        hasStructure &&
        (_structure!.type == StructureType.launcher) &&
        (_structure!.getPlayerId != unit.player.id);
    final bool hasAttacks = unit.remainingAttacks > 0;
    final bool canAttack = unit.type.damageStructure > 0;
    const bool inDistance = true;
    //distance(unit) >= unit.minAttackRange &&
    //distance(unit) <= unit.maxAttackRange;

    return hasOpponentBase && hasAttacks && canAttack && inDistance;
  }*/

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);
}
