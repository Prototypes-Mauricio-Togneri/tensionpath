import 'package:json_annotation/json_annotation.dart';
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

  const JsonUnit({
    required this.type,
    required this.cost,
    required this.maxHealth,
    required this.health,
    required this.attackRange,
    required this.movementRange,
    required this.visibilityRange,
    required this.attack,
  });

  factory JsonUnit.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitToJson(this);
}
