import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_event_unit_created.g.dart';

@JsonSerializable()
class JsonEventUnitCreated {
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

  @JsonKey(name: 'lockedLocation')
  final JsonLocation? lockedLocation;

  @JsonKey(name: 'targetBase')
  final JsonLocation? targetBase;

  @JsonKey(name: 'targetUnitId')
  final String? targetUnitId;

  const JsonEventUnitCreated({
    required this.id,
    required this.playerIndex,
    required this.type,
    required this.health,
    required this.currentPosition,
    required this.targetPosition,
    required this.lockedLocation,
    required this.targetBase,
    required this.targetUnitId,
  });

  factory JsonEventUnitCreated.fromJson(Map<String, dynamic> json) =>
      _$JsonEventUnitCreatedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventUnitCreatedToJson(this);
}
