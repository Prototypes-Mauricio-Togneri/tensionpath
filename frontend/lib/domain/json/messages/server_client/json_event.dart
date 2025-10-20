import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_match_finished.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_player.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_resource_depleted.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_attacked.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_created.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_destroyed.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_ended.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_started.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_event.g.dart';

@JsonSerializable()
class JsonEvent {
  @JsonKey(name: 'missile')
  final JsonEventMissile? missile;

  @JsonKey(name: 'player')
  final JsonEventPlayer? player;

  @JsonKey(name: 'resourceDepleted')
  final JsonEventResourceDepleted? resourceDepleted;

  @JsonKey(name: 'unitCreated')
  final JsonEventUnitCreated? unitCreated;

  @JsonKey(name: 'unitMovementStarted')
  final JsonEventUnitMovementStarted? unitMovementStarted;

  @JsonKey(name: 'unitMovementEnded')
  final JsonEventUnitMovementEnded? unitMovementEnded;

  @JsonKey(name: 'unitAttack')
  final JsonEventUnitAttacked? unitAttack;

  @JsonKey(name: 'unitDestroyed')
  final JsonEventUnitDestroyed? unitDestroyed;

  @JsonKey(name: 'matchFinished')
  final JsonEventMatchFinished? matchFinished;

  const JsonEvent({
    this.missile,
    this.player,
    this.resourceDepleted,
    this.unitCreated,
    this.unitMovementStarted,
    this.unitMovementEnded,
    this.unitAttack,
    this.unitDestroyed,
    this.matchFinished,
  });

  factory JsonEvent.missile({
    required num charge,
    required String? owner,
    required Map<String, String?> platforms,
    required bool alarm,
    required bool fired,
  }) => JsonEvent(
    missile: JsonEventMissile(
      charge: charge,
      owner: owner,
      platforms: platforms,
      alarm: alarm,
      fired: fired,
    ),
  );

  factory JsonEvent.player(JsonEventPlayer player) => JsonEvent(player: player);

  factory JsonEvent.unitCreated({
    required String unitId,
    required String playerIndex,
    required UnitType unitType,
    required num health,
    required JsonPosition position,
    required JsonPosition? targetPosition,
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
      targetPosition: targetPosition,
      lockedLocation: lockedLocation,
      targetBase: targetBase,
      targetUnitId: targetUnitId,
    ),
  );

  factory JsonEvent.unitMovementStarted({
    required String unitId,
    required JsonPosition currentPosition,
    required JsonPosition targetPosition,
  }) => JsonEvent(
    unitMovementStarted: JsonEventUnitMovementStarted(
      id: unitId,
      currentPosition: currentPosition,
      targetPosition: targetPosition,
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
    String? targetUnitId,
    JsonLocation? targetBase,
  }) => JsonEvent(
    unitAttack: JsonEventUnitAttacked(
      attackerId: attackerId,
      targetUnitId: targetUnitId,
      targetBase: targetBase,
      damage: damage,
    ),
  );

  factory JsonEvent.unitDestroyed(String unitId) => JsonEvent(
    unitDestroyed: JsonEventUnitDestroyed(id: unitId),
  );

  factory JsonEvent.resourceDepleted(String resourceId) => JsonEvent(
    resourceDepleted: JsonEventResourceDepleted(id: resourceId),
  );

  factory JsonEvent.matchFinished(String winner) => JsonEvent(
    matchFinished: JsonEventMatchFinished(winner: winner),
  );

  factory JsonEvent.fromJson(Map<String, dynamic> json) =>
      _$JsonEventFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventToJson(this);
}
