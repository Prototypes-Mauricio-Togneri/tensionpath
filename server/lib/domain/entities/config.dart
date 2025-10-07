import 'package:tensionpath/domain/json/models/common/json_config.dart';

class Config {
  final int resourcesStart;
  final int resourcesPerPatch;
  final num resourcesPassiveRate;
  final num resourcesActiveRate;
  final int maxHarvestersCount;
  final int harvesterReward;
  final num popcapRate; // TODO(momo): use
  final int missileMaxCharge;
  final int missileChargeBuffer;
  final num missileChargeRate;
  final num missileDamage;
  final int baseHealth;

  const Config({
    required this.resourcesStart,
    required this.resourcesPerPatch,
    required this.resourcesPassiveRate,
    required this.resourcesActiveRate,
    required this.maxHarvestersCount,
    required this.harvesterReward,
    required this.popcapRate,
    required this.missileMaxCharge,
    required this.missileChargeBuffer,
    required this.missileChargeRate,
    required this.missileDamage,
    required this.baseHealth,
  });

  factory Config.fromJson(JsonConfig json) => Config(
    resourcesStart: json.resourcesStart,
    resourcesPerPatch: json.resourcesPerPatch,
    resourcesPassiveRate: json.resourcesPassiveRate,
    resourcesActiveRate: json.resourcesActiveRate,
    maxHarvestersCount: json.maxHarvestersCount,
    harvesterReward: json.harvesterReward,
    popcapRate: json.popcapRate,
    missileMaxCharge: json.missileMaxCharge,
    missileChargeBuffer: json.missileChargeBuffer,
    missileChargeRate: json.missileChargeRate,
    missileDamage: json.missileDamage,
    baseHealth: json.baseHealth,
  );

  JsonConfig toJson() => JsonConfig(
    resourcesStart: resourcesStart,
    resourcesPerPatch: resourcesPerPatch,
    resourcesPassiveRate: resourcesPassiveRate,
    resourcesActiveRate: resourcesActiveRate,
    maxHarvestersCount: maxHarvestersCount,
    harvesterReward: harvesterReward,
    popcapRate: popcapRate,
    missileMaxCharge: missileMaxCharge,
    missileChargeBuffer: missileChargeBuffer,
    missileChargeRate: missileChargeRate,
    missileDamage: missileDamage,
    baseHealth: baseHealth,
  );
}
