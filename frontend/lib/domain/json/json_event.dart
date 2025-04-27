import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';
import 'package:uuid/uuid.dart';

part 'json_event.g.dart';

@JsonSerializable()
class JsonEvent {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'type')
  final EventType type;

  @JsonKey(name: 'timestamp', toJson: dateToJson)
  final DateTime timestamp;

  @JsonKey(name: 'nodeIdOrigin')
  final String? nodeIdOrigin;

  @JsonKey(name: 'nodeIdTarget')
  final String? nodeIdTarget;

  @JsonKey(name: 'unitType')
  final UnitType? unitType;

  const JsonEvent({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.nodeIdOrigin,
    required this.nodeIdTarget,
    required this.unitType,
  });

  factory JsonEvent.deployUnit({
    required UnitType unitType,
    required String nodeIdTarget,
  }) => JsonEvent(
    id: const Uuid().v4(),
    type: EventType.deploy_unit,
    timestamp: DateTime.now(),
    nodeIdOrigin: null,
    nodeIdTarget: nodeIdTarget,
    unitType: unitType,
  );

  factory JsonEvent.moveUnit({
    required String nodeIdOrigin,
    required String nodeIdTarget,
  }) => JsonEvent(
    id: const Uuid().v4(),
    type: EventType.move_unit,
    timestamp: DateTime.now(),
    nodeIdOrigin: nodeIdOrigin,
    nodeIdTarget: nodeIdTarget,
    unitType: null,
  );

  factory JsonEvent.attackUnit({
    required String nodeIdOrigin,
    required String nodeIdTarget,
  }) => JsonEvent(
    id: const Uuid().v4(),
    type: EventType.attack_unit,
    timestamp: DateTime.now(),
    nodeIdOrigin: nodeIdOrigin,
    nodeIdTarget: nodeIdTarget,
    unitType: null,
  );

  factory JsonEvent.attackBase({
    required String nodeIdOrigin,
    required String nodeIdTarget,
  }) => JsonEvent(
    id: const Uuid().v4(),
    type: EventType.attack_base,
    timestamp: DateTime.now(),
    nodeIdOrigin: nodeIdOrigin,
    nodeIdTarget: nodeIdTarget,
    unitType: null,
  );

  factory JsonEvent.endTurnSelf() => JsonEvent(
    id: const Uuid().v4(),
    type: EventType.end_turn_self,
    timestamp: DateTime.now(),
    nodeIdOrigin: null,
    nodeIdTarget: null,
    unitType: null,
  );

  factory JsonEvent.endTurnOpponent() => JsonEvent(
    id: const Uuid().v4(),
    type: EventType.end_turn_opponent,
    timestamp: DateTime.now(),
    nodeIdOrigin: null,
    nodeIdTarget: null,
    unitType: null,
  );

  factory JsonEvent.fromJson(Map<String, dynamic> json) =>
      _$JsonEventFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventToJson(this);
}

enum EventType {
  deploy_unit,
  move_unit,
  attack_unit,
  attack_base,
  end_turn_self,
  end_turn_opponent,
}
