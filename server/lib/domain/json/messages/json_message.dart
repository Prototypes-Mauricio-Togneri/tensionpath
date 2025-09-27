import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_attack_unit.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_deploy_unit.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_move_unit.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_unit_action.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_error.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_finish.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_start.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_update.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_welcome.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_message.g.dart';

@JsonSerializable()
class JsonMessage {
  // =========================== CLIENT -> SERVER =========================== \\

  @JsonKey(name: 'join')
  final JsonJoinMatch? join;

  @JsonKey(name: 'deploy')
  final JsonDeployUnit? deploy;

  @JsonKey(name: 'move')
  final JsonMoveUnit? move;

  @JsonKey(name: 'attackUnit')
  final JsonAttackUnit? attackUnit;

  @JsonKey(name: 'action')
  final JsonUnitAction? action;

  // =========================== SERVER -> CLIENT =========================== \\

  @JsonKey(name: 'welcome')
  final JsonWelcome? welcome;

  @JsonKey(name: 'start')
  final JsonStart? start;

  @JsonKey(name: 'update')
  final JsonUpdate? update;

  @JsonKey(name: 'finish')
  final JsonFinish? finish;

  @JsonKey(name: 'error')
  final JsonError? error;

  const JsonMessage({
    // Client -> Server
    this.join,
    this.deploy,
    this.move,
    this.attackUnit,
    this.action,

    // Server -> Client
    this.welcome,
    this.start,
    this.update,
    this.finish,
    this.error,
  });

  dynamic get message {
    if (join != null) {
      return join;
    } else if (deploy != null) {
      return deploy;
    } else if (move != null) {
      return move;
    } else if (attackUnit != null) {
      return attackUnit;
    } else if (action != null) {
      return action;
    } else if (welcome != null) {
      return welcome;
    } else if (start != null) {
      return start;
    } else if (update != null) {
      return update;
    } else if (finish != null) {
      return finish;
    } else if (error != null) {
      return error;
    } else {
      throw JsonMessage.error('Unknown message');
    }
  }

  factory JsonMessage.fromJson(Map<String, dynamic> json) =>
      _$JsonMessageFromJson(json);

  factory JsonMessage.join({
    required String matchId,
    required String playerId,
  }) => JsonMessage(
    join: JsonJoinMatch(
      matchId: matchId,
      playerId: playerId,
    ),
  );

  factory JsonMessage.deployUnit({
    required String matchId,
    required JsonLocation location,
    required UnitType type,
  }) => JsonMessage(
    deploy: JsonDeployUnit(
      matchId: matchId,
      location: location,
      type: type,
    ),
  );

  factory JsonMessage.moveUnit({
    required String matchId,
    required String unitId,
    required JsonLocation location,
  }) => JsonMessage(
    move: JsonMoveUnit(
      matchId: matchId,
      unitId: unitId,
      location: location,
    ),
  );

  factory JsonMessage.attackUnit({
    required String matchId,
    required String attackerUnitId,
    required String defenderUnitId,
  }) => JsonMessage(
    attackUnit: JsonAttackUnit(
      matchId: matchId,
      attackerUnitId: attackerUnitId,
      defenderUnitId: defenderUnitId,
    ),
  );

  factory JsonMessage.unitAction({
    required String matchId,
    required String unitId,
    required JsonLocation? targetLocation,
    required String? targetUnitId,
  }) => JsonMessage(
    action: JsonUnitAction(
      matchId: matchId,
      unitId: unitId,
      targetLocation: targetLocation,
      targetUnitId: targetUnitId,
    ),
  );

  factory JsonMessage.welcome() => JsonMessage(
    welcome: JsonWelcome(),
  );

  factory JsonMessage.start(JsonMatchStart match) => JsonMessage(
    start: JsonStart(match: match),
  );

  factory JsonMessage.update(JsonMatchUpdate match) => JsonMessage(
    update: JsonUpdate(match: match),
  );

  factory JsonMessage.finish(String winner) => JsonMessage(
    finish: JsonFinish(winner: winner),
  );

  factory JsonMessage.error(String message) => JsonMessage(
    error: JsonError(message: message),
  );

  Map<String, dynamic> toJson() => _$JsonMessageToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
