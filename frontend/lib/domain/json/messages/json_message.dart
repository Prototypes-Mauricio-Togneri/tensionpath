import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/game/json_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_battle.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_launch_units.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_error.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_update.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_welcome.dart';

part 'json_message.g.dart';

@JsonSerializable()
class JsonMessage {
  @JsonKey(name: 'error')
  final JsonError? error;

  @JsonKey(name: 'welcome')
  final JsonWelcome? welcome;

  @JsonKey(name: 'update')
  final JsonUpdate? update;

  @JsonKey(name: 'joinBattle')
  final JsonJoinBattle? joinBattle;

  @JsonKey(name: 'launchUnits')
  final JsonLaunchUnits? launchUnits;

  const JsonMessage({
    this.error,
    this.welcome,
    this.update,
    this.joinBattle,
    this.launchUnits,
  });

  dynamic get message {
    if (error != null) {
      return error;
    } else if (welcome != null) {
      return welcome;
    } else if (update != null) {
      return update;
    } else if (joinBattle != null) {
      return joinBattle;
    } else if (launchUnits != null) {
      return launchUnits;
    } else {
      throw JsonMessage.error('Unknown message');
    }
  }

  factory JsonMessage.fromString(String json) =>
      JsonMessage.fromJson(jsonDecode(json));

  factory JsonMessage.fromJson(Map<String, dynamic> json) =>
      _$JsonMessageFromJson(json);

  factory JsonMessage.error(String message) => JsonMessage(
    error: JsonError(message: message),
  );

  factory JsonMessage.welcome() => JsonMessage(
    welcome: JsonWelcome(),
  );

  factory JsonMessage.update(JsonMatch match) => JsonMessage(
    update: JsonUpdate(match: match),
  );

  factory JsonMessage.joinBattle({
    required String battleId,
    required String playerId,
  }) => JsonMessage(
    joinBattle: JsonJoinBattle(
      battleId: battleId,
      playerId: playerId,
    ),
  );

  factory JsonMessage.launchUnits({
    required String battleId,
    required int laneId,
    required int amount,
  }) => JsonMessage(
    launchUnits: JsonLaunchUnits(
      battleId: battleId,
      laneId: laneId,
      amount: amount,
    ),
  );

  Map<String, dynamic> toJson() => _$JsonMessageToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
