import 'dart:math';
import 'package:tensionpath/domain/json/models/common/json_config.dart';

class Config {
  final int resourcesStart;
  final int resourcesPerPatch;
  final num resourcesDamage;
  final num resourcesPassiveRate;
  final num resourcesActiveRate;
  final int maxHarvestersCount;
  final int harvesterReward;
  final int popcapInitial;
  final int popcapMax;
  final num popcapRate;
  final int missileMaxCharge;
  final int missileChargeBuffer;
  final int missileChargeAlarm;
  final num missileChargeRate;
  final num missileDamage;
  final int baseHealth;
  final int matchTimeout;
  final int suddenDeathTimeout;
  final int suddenDeathDamage;

  const Config({
    required this.resourcesStart,
    required this.resourcesPerPatch,
    required this.resourcesDamage,
    required this.resourcesPassiveRate,
    required this.resourcesActiveRate,
    required this.maxHarvestersCount,
    required this.harvesterReward,
    required this.popcapInitial,
    required this.popcapMax,
    required this.popcapRate,
    required this.missileMaxCharge,
    required this.missileChargeBuffer,
    required this.missileChargeAlarm,
    required this.missileChargeRate,
    required this.missileDamage,
    required this.baseHealth,
    required this.matchTimeout,
    required this.suddenDeathTimeout,
    required this.suddenDeathDamage,
  });

  int popcapAtTime(num elapsedTime) {
    final int extraPopcap = (elapsedTime / popcapRate).floor();

    return min(popcapInitial + extraPopcap, popcapMax);
  }

  factory Config.fromJson(JsonConfig json) => Config(
    resourcesStart: json.resourcesStart,
    resourcesPerPatch: json.resourcesPerPatch,
    resourcesDamage: json.resourcesDamage,
    resourcesPassiveRate: json.resourcesPassiveRate,
    resourcesActiveRate: json.resourcesActiveRate,
    maxHarvestersCount: json.maxHarvestersCount,
    harvesterReward: json.harvesterReward,
    popcapInitial: json.popcapInitial,
    popcapMax: json.popcapMax,
    popcapRate: json.popcapRate,
    missileMaxCharge: json.missileMaxCharge,
    missileChargeBuffer: json.missileChargeBuffer,
    missileChargeAlarm: json.missileChargeAlarm,
    missileChargeRate: json.missileChargeRate,
    missileDamage: json.missileDamage,
    baseHealth: json.baseHealth,
    matchTimeout: json.matchTimeout,
    suddenDeathTimeout: json.suddenDeathTimeout,
    suddenDeathDamage: json.suddenDeathDamage,
  );

  JsonConfig toJson() => JsonConfig(
    resourcesStart: resourcesStart,
    resourcesPerPatch: resourcesPerPatch,
    resourcesDamage: resourcesDamage,
    resourcesPassiveRate: resourcesPassiveRate,
    resourcesActiveRate: resourcesActiveRate,
    maxHarvestersCount: maxHarvestersCount,
    harvesterReward: harvesterReward,
    popcapInitial: popcapInitial,
    popcapMax: popcapMax,
    popcapRate: popcapRate,
    missileMaxCharge: missileMaxCharge,
    missileChargeBuffer: missileChargeBuffer,
    missileChargeAlarm: missileChargeAlarm,
    missileChargeRate: missileChargeRate,
    missileDamage: missileDamage,
    baseHealth: baseHealth,
    matchTimeout: matchTimeout,
    suddenDeathTimeout: suddenDeathTimeout,
    suddenDeathDamage: suddenDeathDamage,
  );
}
