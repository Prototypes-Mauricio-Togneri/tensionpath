import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/resource.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_match_finished.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_player.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_resource_depleted.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_created.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_destroyed.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_ended.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_started.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_updated.dart';

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

  factory JsonEvent.unitCreated(Unit unit) => JsonEvent(
    unitCreated: JsonEventUnitCreated(
      id: unit.id,
      playerIndex: unit.player.id,
      type: unit.type,
      health: unit.health,
      currentPosition: unit.position.toJson(),
      targetPosition: unit.targetNode?.position.toJson(),
      lockedLocation: unit.lockedNode?.location.toJson(),
      targetBase: unit.targetBase?.location.toJson(),
      targetUnitId: unit.targetUnit?.id,
    ),
  );

  factory JsonEvent.unitMovementStarted(Unit unit) => JsonEvent(
    unitMovementStarted: JsonEventUnitMovementStarted(
      id: unit.id,
      currentPosition: unit.position.toJson(),
      targetPosition: unit.targetNode!.position.toJson(),
    ),
  );

  factory JsonEvent.unitMovementEnded(Unit unit) => JsonEvent(
    unitMovementEnded: JsonEventUnitMovementEnded(
      id: unit.id,
      currentPosition: unit.position.toJson(),
      lockedLocation: unit.lockedNode?.location.toJson(),
    ),
  );

  factory JsonEvent.unitUpdated(Unit unit) => JsonEvent(
    unitUpdated: JsonEventUnitUpdated(
      id: unit.id,
      health: unit.health,
    ),
  );

  factory JsonEvent.unitDestroyed(Unit unit) => JsonEvent(
    unitDestroyed: JsonEventUnitDestroyed(id: unit.id),
  );

  factory JsonEvent.resourceDepleted(Resource resource) => JsonEvent(
    resourceDepleted: JsonEventResourceDepleted(id: resource.id),
  );

  factory JsonEvent.matchFinished(String winner) => JsonEvent(
    matchFinished: JsonEventMatchFinished(winner: winner),
  );

  factory JsonEvent.fromJson(Map<String, dynamic> json) =>
      _$JsonEventFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventToJson(this);
}
