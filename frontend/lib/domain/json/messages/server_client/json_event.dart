import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_match_finished.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_player.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_resource_depleted.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_created.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_destroyed.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_ended.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_started.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_updated.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_event.g.dart';

@JsonSerializable()
class JsonEvent {
  @JsonKey(name: 'missile')
  final JsonEventMissile? missile; // on update: OK

  @JsonKey(name: 'player')
  final JsonEventPlayer? player; // on update: OK

  @JsonKey(name: 'resource_depleted')
  final JsonEventResourceDepleted? resourceDepleted; // on update: OK

  @JsonKey(name: 'unit_created')
  final JsonEventUnitCreated? unitCreated; // on message: OK

  @JsonKey(name: 'unit_movement_started')
  final JsonEventUnitMovementStarted? unitMovementStarted; // on message: OK

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
    required Position position,
    required Position? targetPosition,
    required Location? lockedLocation,
    required Location? targetBase,
    required String? targetUnitId,
  }) => JsonEvent(
    unitCreated: JsonEventUnitCreated(
      id: unitId,
      playerIndex: playerIndex,
      type: unitType,
      health: health,
      currentPosition: position.toJson(),
      targetPosition: targetPosition?.toJson(),
      lockedLocation: lockedLocation?.toJson(),
      targetBase: targetBase?.toJson(),
      targetUnitId: targetUnitId,
    ),
  );

  factory JsonEvent.unitMovementStarted({
    required String unitId,
    required Position currentPosition,
    required Position targetPosition,
  }) => JsonEvent(
    unitMovementStarted: JsonEventUnitMovementStarted(
      id: unitId,
      currentPosition: currentPosition.toJson(),
      targetPosition: targetPosition.toJson(),
    ),
  );

  factory JsonEvent.unitMovementEnded({
    required String unitId,
    required Position currentPosition,
    required Location? lockedLocation,
  }) => JsonEvent(
    unitMovementEnded: JsonEventUnitMovementEnded(
      id: unitId,
      currentPosition: currentPosition.toJson(),
      lockedLocation: lockedLocation?.toJson(),
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
