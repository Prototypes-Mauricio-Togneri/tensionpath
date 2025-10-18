import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_created.dart';

part 'json_event.g.dart';

@JsonSerializable()
class JsonEvent {
  @JsonKey(name: 'unit_created')
  final JsonEventUnitCreated? unitCreated;

  // player update
  //   * health
  //   * resources
  //   * resourcesRate
  //   * currentHarvesterCount
  // missile
  //   * charge
  //   * missile owner
  //   * platform owner
  //   * alarm: bool
  //   * fired: bool
  // resource depleted
  // unit created
  // unit update
  //   * health
  //   * locked node
  //   * move
  //   * attack (target? damage?)
  // unit destroyed
  // match finished
  //   * winner
  //   * loser
  //   * draw

  const JsonEvent({
    this.unitCreated,
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
