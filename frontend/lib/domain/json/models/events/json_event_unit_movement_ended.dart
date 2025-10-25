import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

part 'json_event_unit_movement_ended.g.dart';

@JsonSerializable()
class JsonEventUnitMovementEnded {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'currentPosition')
  final JsonPosition currentPosition;

  @JsonKey(name: 'lockedLocation')
  final JsonLocation? lockedLocation;

  const JsonEventUnitMovementEnded({
    required this.id,
    required this.currentPosition,
    required this.lockedLocation,
  });

  factory JsonEventUnitMovementEnded.fromJson(Map<String, dynamic> json) =>
      _$JsonEventUnitMovementEndedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventUnitMovementEndedToJson(this);
}
