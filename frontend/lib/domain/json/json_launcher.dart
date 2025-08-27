import 'package:json_annotation/json_annotation.dart';

part 'json_launcher.g.dart';

@JsonSerializable()
class JsonLauncher {
  @JsonKey(name: 'playerId')
  final String playerId;

  const JsonLauncher({required this.playerId});

  factory JsonLauncher.fromJson(Map<String, dynamic> json) =>
      _$JsonLauncherFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLauncherToJson(this);
}
