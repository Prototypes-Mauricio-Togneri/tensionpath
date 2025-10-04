import 'package:tensionpath/domain/json/models/template/json_config_template.dart';

class Config {
  final num resourcesPerPatch;
  final num resourcesRate;
  final num popcapRate;
  final num missileMaxCharge;
  final num missileChargeBuffer;
  final num missileChargeRate;
  final num missileDamage;
  final num baseHealth;

  const Config({
    required this.resourcesPerPatch,
    required this.resourcesRate,
    required this.popcapRate,
    required this.missileMaxCharge,
    required this.missileChargeBuffer,
    required this.missileChargeRate,
    required this.missileDamage,
    required this.baseHealth,
  });

  factory Config.fromJson(JsonConfigTemplate json) => Config(
    resourcesPerPatch: json.resourcesPerPatch,
    resourcesRate: json.resourcesRate,
    popcapRate: json.popcapRate,
    missileMaxCharge: json.missileMaxCharge,
    missileChargeBuffer: json.missileChargeBuffer,
    missileChargeRate: json.missileChargeRate,
    missileDamage: json.missileDamage,
    baseHealth: json.baseHealth,
  );
}
