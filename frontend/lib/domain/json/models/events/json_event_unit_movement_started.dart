import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

part 'json_event_unit_movement_started.g.dart';

@JsonSerializable()
class JsonEventUnitMovementStarted {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'currentPosition')
  final JsonPosition currentPosition;

  @JsonKey(name: 'targetPositions')
  final List<JsonPosition> targetPositions;

  const JsonEventUnitMovementStarted({
    required this.id,
    required this.currentPosition,
    required this.targetPositions,
  });

  factory JsonEventUnitMovementStarted.fromJson(Map<String, dynamic> json) =>
      _$JsonEventUnitMovementStartedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventUnitMovementStartedToJson(this);
}
