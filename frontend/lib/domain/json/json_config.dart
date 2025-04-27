import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/config.dart';

part 'json_config.g.dart';

@JsonSerializable()
class JsonConfig {
  @JsonKey(name: 'resourcesPerPatch')
  final int resourcesPerPatch;

  @JsonKey(name: 'resourcesPerTurn')
  final int resourcesPerTurn;

  @JsonKey(name: 'resourcesPerSecond')
  final int resourcesPerSecond;

  @JsonKey(name: 'popcap')
  final int popcap;

  const JsonConfig({
    required this.resourcesPerPatch,
    required this.resourcesPerTurn,
    required this.resourcesPerSecond,
    required this.popcap,
  });

  Config get object => Config(
    resourcesPerPatch: resourcesPerPatch,
    resourcesPerTurn: resourcesPerTurn,
    resourcesPerSecond: resourcesPerSecond,
    popcap: popcap,
  );

  factory JsonConfig.fromJson(Map<String, dynamic> json) =>
      _$JsonConfigFromJson(json);

  Map<String, dynamic> toJson() => _$JsonConfigToJson(this);
}
