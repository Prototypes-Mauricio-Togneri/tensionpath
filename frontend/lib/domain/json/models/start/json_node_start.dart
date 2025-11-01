import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/node_type.dart';

part 'json_node_start.g.dart';

@JsonSerializable()
class JsonNodeStart {
  @JsonKey(name: 'type')
  final NodeType type;

  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'playerIndex')
  final String? playerIndex;

  @JsonKey(name: 'platformId')
  final String? platformId;

  @JsonKey(name: 'building')
  final BuildingType? building;

  JsonNodeStart({
    required this.type,
    required this.location,
    required this.position,
    required this.playerIndex,
    required this.platformId,
    required this.building,
  });

  factory JsonNodeStart.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeStartToJson(this);
}
