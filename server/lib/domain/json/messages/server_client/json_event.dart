import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_match_finished.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_player.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_resource_depleted.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_created.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_destroyed.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_ended.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_started.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_updated.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_event.g.dart';

@JsonSerializable()
class JsonEvent {
  @JsonKey(name: 'missile')
  final JsonEventMissile? missile;

  @JsonKey(name: 'player')
  final JsonEventPlayer? player; // on update: OK

  @JsonKey(name: 'resource_depleted')
  final JsonEventResourceDepleted? resourceDepleted; // on update: OK

  @JsonKey(name: 'unit_created')
  final JsonEventUnitCreated? unitCreated;

  @JsonKey(name: 'unit_movement_started')
  final JsonEventUnitMovementStarted? unitMovementStarted;

  @JsonKey(name: 'unit_movement_ended')
  final JsonEventUnitMovementEnded? unitMovementEnded; // on update

  @JsonKey(name: 'unit_updated')
  final JsonEventUnitUpdated? unitUpdated; // on update

  @JsonKey(name: 'unit_destroyed')
  final JsonEventUnitDestroyed? unitDestroyed; // on update: OK

  @JsonKey(name: 'match_finished')
  final JsonEventMatchFinished? matchFinished; // on update: OK

  const JsonEvent({
    this.missile,
    this.player,
    this.resourceDepleted,
    this.unitCreated,
    this.unitMovementStarted,
    this.unitMovementEnded,
    this.unitUpdated,
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

  factory JsonEvent.unitUpdated({
    required String unitId,
    required num health,
  }) => JsonEvent(
    unitUpdated: JsonEventUnitUpdated(
      id: unitId,
      health: health,
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
