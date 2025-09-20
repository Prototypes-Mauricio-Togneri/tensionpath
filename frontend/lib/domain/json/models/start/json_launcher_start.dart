import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

part 'json_launcher_start.g.dart';

@JsonSerializable()
class JsonLauncherStart {
  @JsonKey(name: 'playerIndex')
  final String playerIndex;

  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'position')
  final JsonPosition position;

  const JsonLauncherStart({
    required this.playerIndex,
    required this.location,
    required this.position,
  });

  factory JsonLauncherStart.fromJson(Map<String, dynamic> json) =>
      _$JsonLauncherStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLauncherStartToJson(this);
}
