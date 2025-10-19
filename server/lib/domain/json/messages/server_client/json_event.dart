import 'package:json_annotation/json_annotation.dart';
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
  final JsonEventMissile? missile; // on update

  @JsonKey(name: 'player')
  final JsonEventPlayer? player; // on update

  @JsonKey(name: 'resource_depleted')
  final JsonEventResourceDepleted? resourceDepleted; // on update

  @JsonKey(name: 'unit_created')
  final JsonEventUnitCreated? unitCreated; // on message

  @JsonKey(name: 'unit_movement_started')
  final JsonEventUnitMovementStarted? unitMovementStarted; // on message

  @JsonKey(name: 'unit_movement_ended')
  final JsonEventUnitMovementEnded? unitMovementEnded; // on update

  @JsonKey(name: 'unit_updated')
  final JsonEventUnitUpdated? unitUpdated; // on update

  @JsonKey(name: 'unit_destroyed')
  final JsonEventUnitDestroyed? unitDestroyed; // on update

  @JsonKey(name: 'match_finished')
  final JsonEventMatchFinished? matchFinished; // on update

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

  factory JsonEvent.fromJson(Map<String, dynamic> json) =>
      _$JsonEventFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventToJson(this);
}
