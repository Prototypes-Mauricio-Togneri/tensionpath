import 'package:tensionpath/domain/json/models/common/json_config.dart';

class Config {
  final int resourcesStart;
  final int resourcesPerPatch;
  final num resourcesPassiveRate;
  final num resourcesActiveRate;
  final int maxHarvestersCount;
  final int harvesterReward;
  final int popcapInitial;
  final num popcapRate;
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
    required this.popcapInitial,
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
    popcapInitial: json.popcapInitial,
    popcapRate: json.popcapRate,
    missileMaxCharge: json.missileMaxCharge,
    missileChargeBuffer: json.missileChargeBuffer,
    missileChargeRate: json.missileChargeRate,
    missileDamage: json.missileDamage,
    baseHealth: json.baseHealth,
  );
}
