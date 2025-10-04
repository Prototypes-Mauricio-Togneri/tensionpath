import 'package:tensionpath/domain/json/models/template/json_config_template.dart';

class Config {
  final num resourcesStart;
  final num resourcesPerPatch;
  final num resourcesPassiveRate;
  final num resourcesHarvestRate;
  final num popcapRate;
  final num missileMaxCharge;
  final num missileChargeBuffer;
  final num missileChargeRate;
  final num missileDamage;
  final num baseHealth;

  const Config({
    required this.resourcesStart,
    required this.resourcesPerPatch,
    required this.resourcesPassiveRate,
    required this.resourcesHarvestRate,
    required this.popcapRate,
    required this.missileMaxCharge,
    required this.missileChargeBuffer,
    required this.missileChargeRate,
    required this.missileDamage,
    required this.baseHealth,
  });

  factory Config.fromJson(JsonConfigTemplate json) => Config(
    resourcesStart: json.resourcesStart,
    resourcesPerPatch: json.resourcesPerPatch,
    resourcesPassiveRate: json.resourcesPassiveRate,
    resourcesHarvestRate: json.resourcesHarvestRate,
    popcapRate: json.popcapRate,
    missileMaxCharge: json.missileMaxCharge,
    missileChargeBuffer: json.missileChargeBuffer,
    missileChargeRate: json.missileChargeRate,
    missileDamage: json.missileDamage,
    baseHealth: json.baseHealth,
  );
}
