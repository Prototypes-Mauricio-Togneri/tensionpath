import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/json/models/events/json_event_base_damaged.dart';
import 'package:tensionpath/domain/json/models/events/json_event_building_unlocked.dart';
import 'package:tensionpath/domain/json/models/events/json_event_match_finished.dart';
import 'package:tensionpath/domain/json/models/events/json_event_match_status.dart';
import 'package:tensionpath/domain/json/models/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/models/events/json_event_player.dart';
import 'package:tensionpath/domain/json/models/events/json_event_popcap.dart';
import 'package:tensionpath/domain/json/models/events/json_event_resource_depleted.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_attack.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_created.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_damaged.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_movement_ended.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_movement_started.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_event.g.dart';

@JsonSerializable()
class JsonEvent {
  @JsonKey(name: 'status')
  final JsonEventMatchStatus? status;

  @JsonKey(name: 'missile')
  final JsonEventMissile? missile;

  @JsonKey(name: 'player')
  final JsonEventPlayer? player;

  @JsonKey(name: 'popcap')
  final JsonEventPopcap? popcap;

  @JsonKey(name: 'baseDamaged')
  final JsonEventBaseDamaged? baseDamaged;

  @JsonKey(name: 'resourceDepleted')
  final JsonEventResourceDepleted? resourceDepleted;

  @JsonKey(name: 'buildingUnlocked')
  final JsonEventBuildingUnlocked? buildingUnlocked;

  @JsonKey(name: 'unitCreated')
  final JsonEventUnitCreated? unitCreated;

  @JsonKey(name: 'unitMovementStarted')
  final JsonEventUnitMovementStarted? unitMovementStarted;

  @JsonKey(name: 'unitMovementEnded')
  final JsonEventUnitMovementEnded? unitMovementEnded;

  @JsonKey(name: 'unitAttack')
  final JsonEventUnitAttack? unitAttack;

  @JsonKey(name: 'unitDamaged')
  final JsonEventUnitDamaged? unitDamaged;

  @JsonKey(name: 'matchFinished')
  final JsonEventMatchFinished? matchFinished;

  const JsonEvent({
    this.status,
    this.missile,
    this.player,
    this.popcap,
    this.baseDamaged,
    this.resourceDepleted,
    this.buildingUnlocked,
    this.unitCreated,
    this.unitMovementStarted,
    this.unitMovementEnded,
    this.unitAttack,
    this.unitDamaged,
    this.matchFinished,
  });

  factory JsonEvent.matchStatus(MatchStatus status) => JsonEvent(
    status: JsonEventMatchStatus(status: status),
  );

  factory JsonEvent.missile({
    required num charge,
    required String? owner,
    required Map<String, String?> platforms,
    required bool fired,
    required String? playerIndex,
    required num? damage,
  }) => JsonEvent(
    missile: JsonEventMissile(
      charge: charge,
      owner: owner,
      platforms: platforms,
      fired: fired,
      playerIndex: playerIndex,
      damage: damage,
    ),
  );

  factory JsonEvent.player(JsonEventPlayer player) => JsonEvent(player: player);

  factory JsonEvent.popcap(int popcap) => JsonEvent(
    popcap: JsonEventPopcap(popcap: popcap),
  );

  factory JsonEvent.baseDamaged({
    required String playerIndex,
    required num damage,
  }) => JsonEvent(
    baseDamaged: JsonEventBaseDamaged(
      playerIndex: playerIndex,
      damage: damage,
    ),
  );

  factory JsonEvent.buildingUnlocked({
    required String playerIndex,
    required BuildingType buildingType,
  }) => JsonEvent(
    buildingUnlocked: JsonEventBuildingUnlocked(
      playerIndex: playerIndex,
      type: buildingType,
    ),
  );

  factory JsonEvent.unitCreated({
    required String unitId,
    required String playerIndex,
    required UnitType unitType,
    required num health,
    required JsonPosition position,
    required List<JsonPosition> targetPositions,
    required JsonLocation? lockedLocation,
    required JsonLocation? targetBase,
    required String? targetUnitId,
  }) => JsonEvent(
    unitCreated: JsonEventUnitCreated(
      id: unitId,
      playerIndex: playerIndex,
      type: unitType,
      health: health,
      currentPosition: position,
      targetPositions: targetPositions,
      lockedLocation: lockedLocation,
      targetBase: targetBase,
      targetUnitId: targetUnitId,
    ),
  );

  factory JsonEvent.unitMovementStarted({
    required String unitId,
    required JsonPosition currentPosition,
    required List<JsonPosition> targetPositions,
  }) => JsonEvent(
    unitMovementStarted: JsonEventUnitMovementStarted(
      id: unitId,
      currentPosition: currentPosition,
      targetPositions: targetPositions,
    ),
  );

  factory JsonEvent.unitMovementEnded({
    required String unitId,
    required JsonPosition currentPosition,
    required JsonLocation? lockedLocation,
  }) => JsonEvent(
    unitMovementEnded: JsonEventUnitMovementEnded(
      id: unitId,
      currentPosition: currentPosition,
      lockedLocation: lockedLocation,
    ),
  );

  factory JsonEvent.unitAttack({
    required String attackerId,
    required num damage,
    required bool targetDestroyed,
    String? targetUnitId,
    JsonLocation? targetBaseLocation,
  }) => JsonEvent(
    unitAttack: JsonEventUnitAttack(
      attackerId: attackerId,
      targetUnitId: targetUnitId,
      targetBaseLocation: targetBaseLocation,
      damage: damage,
      targetDestroyed: targetDestroyed,
    ),
  );

  factory JsonEvent.unitDamaged({
    required String unitId,
    required num damage,
    required bool unitDestroyed,
  }) => JsonEvent(
    unitDamaged: JsonEventUnitDamaged(
      unitId: unitId,
      damage: damage,
      unitDestroyed: unitDestroyed,
    ),
  );

  factory JsonEvent.resourceDepleted(String resourceId) => JsonEvent(
    resourceDepleted: JsonEventResourceDepleted(id: resourceId),
  );

  factory JsonEvent.matchFinished({
    required String? winner,
    required String? loser,
  }) => JsonEvent(
    matchFinished: JsonEventMatchFinished(winner: winner, loser: loser),
  );

  factory JsonEvent.fromJson(Map<String, dynamic> json) =>
      _$JsonEventFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventToJson(this);
}
