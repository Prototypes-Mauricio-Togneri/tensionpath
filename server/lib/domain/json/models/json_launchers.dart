import 'package:json_annotation/json_annotation.dart';

import 'json_location.dart';

part 'json_launchers.g.dart';

@JsonSerializable()
class JsonLaunchers {
  @JsonKey(name: 'playerIndex')
  final String playerIndex;

  @JsonKey(name: 'locations')
  final List<JsonLocation> locations;

  const JsonLaunchers({
    required this.playerIndex,
    required this.locations,
  });

  factory JsonLaunchers.fromJson(Map<String, dynamic> json) =>
      _$JsonLaunchersFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaunchersToJson(this);
}
