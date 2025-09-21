import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_unit_update.g.dart';

@JsonSerializable()
class JsonUnitUpdate {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'playerIndex')
  final String playerIndex;

  @JsonKey(name: 'type')
  final UnitType type;

  @JsonKey(name: 'health')
  final num health;

  @JsonKey(name: 'currentPosition')
  final JsonPosition currentPosition;

  @JsonKey(name: 'targetPosition')
  final JsonPosition? targetPosition;

  const JsonUnitUpdate({
    required this.id,
    required this.playerIndex,
    required this.type,
    required this.health,
    required this.currentPosition,
    required this.targetPosition,
  });

  factory JsonUnitUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitUpdateToJson(this);
}
