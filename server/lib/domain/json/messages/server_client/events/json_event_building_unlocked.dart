import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/types/building_type.dart';

part 'json_event_building_unlocked.g.dart';

@JsonSerializable()
class JsonEventBuildingUnlocked {
  @JsonKey(name: 'playerIndex')
  final String playerIndex;

  @JsonKey(name: 'type')
  final BuildingType type;

  const JsonEventBuildingUnlocked({
    required this.playerIndex,
    required this.type,
  });

  factory JsonEventBuildingUnlocked.fromJson(Map<String, dynamic> json) =>
      _$JsonEventBuildingUnlockedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventBuildingUnlockedToJson(this);
}
