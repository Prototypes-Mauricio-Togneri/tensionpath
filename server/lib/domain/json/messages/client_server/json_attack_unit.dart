import 'package:json_annotation/json_annotation.dart';

part 'json_attack_unit.g.dart';

@JsonSerializable()
class JsonAttackUnit {
  @JsonKey(name: 'matchId')
  final String matchId;

  @JsonKey(name: 'attackerUnitId')
  final String attackerUnitId;

  @JsonKey(name: 'defenderUnitId')
  final String defenderUnitId;

  const JsonAttackUnit({
    required this.matchId,
    required this.attackerUnitId,
    required this.defenderUnitId,
  });

  factory JsonAttackUnit.fromJson(Map<String, dynamic> json) =>
      _$JsonAttackUnitFromJson(json);

  Map<String, dynamic> toJson() => _$JsonAttackUnitToJson(this);
}
