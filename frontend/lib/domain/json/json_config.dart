import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/config.dart';

part 'json_config.g.dart';

@JsonSerializable()
class JsonConfig {
  @JsonKey(name: 'popcap')
  final int popcap;

  @JsonKey(name: 'baseMaxHealth')
  final int baseMaxHealth;

  @JsonKey(name: 'resourcesPerPatch')
  final int resourcesPerPatch;

  @JsonKey(name: 'resourcesPerTurn')
  final int resourcesPerTurn;

  @JsonKey(name: 'resourcesPerSecond')
  final double resourcesPerSecond;

  @JsonKey(name: 'defenseFactor')
  final double defenseFactor;

  const JsonConfig({
    required this.popcap,
    required this.baseMaxHealth,
    required this.resourcesPerPatch,
    required this.resourcesPerTurn,
    required this.resourcesPerSecond,
    required this.defenseFactor,
  });

  Config get object => Config(
    popcap: popcap,
    baseMaxHealth: baseMaxHealth,
    resourcesPerPatch: resourcesPerPatch,
    resourcesPerTurn: resourcesPerTurn,
    resourcesPerSecond: resourcesPerSecond,
    defenseFactor: defenseFactor,
  );

  factory JsonConfig.fromJson(Map<String, dynamic> json) =>
      _$JsonConfigFromJson(json);

  Map<String, dynamic> toJson() => _$JsonConfigToJson(this);
}
