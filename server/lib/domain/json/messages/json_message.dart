import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/game/json_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_increase_attack.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_increase_mine.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_room.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_launch_units.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_error.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_lane_lost.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_lane_reward_lost.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_lane_reward_won.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_lane_won.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_units_launched.dart';
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

  @JsonKey(name: 'laneRewardWon')
  final JsonLaneRewardWon? laneRewardWon;

  @JsonKey(name: 'laneRewardLost')
  final JsonLaneRewardLost? laneRewardLost;

  @JsonKey(name: 'laneWon')
  final JsonLaneWon? laneWon;

  @JsonKey(name: 'laneLost')
  final JsonLaneLost? laneLost;

  @JsonKey(name: 'unitsLaunched')
  final JsonUnitsLaunched? unitsLaunched;

  @JsonKey(name: 'joinRoom')
  final JsonJoinRoom? joinRoom;

  @JsonKey(name: 'increaseMine')
  final JsonIncreaseMine? increaseMine;

  @JsonKey(name: 'increaseAttack')
  final JsonIncreaseAttack? increaseAttack;

  @JsonKey(name: 'launchUnits')
  final JsonLaunchUnits? launchUnits;

  const JsonMessage({
    this.error,
    this.welcome,
    this.update,
    this.laneRewardWon,
    this.laneRewardLost,
    this.laneWon,
    this.laneLost,
    this.unitsLaunched,
    this.joinRoom,
    this.increaseMine,
    this.increaseAttack,
    this.launchUnits,
  });

  dynamic get message {
    if (error != null) {
      return error;
    } else if (welcome != null) {
      return welcome;
    } else if (update != null) {
      return update;
    } else if (laneRewardWon != null) {
      return laneRewardWon;
    } else if (laneRewardLost != null) {
      return laneRewardLost;
    } else if (laneWon != null) {
      return laneWon;
    } else if (laneLost != null) {
      return laneLost;
    } else if (unitsLaunched != null) {
      return unitsLaunched;
    } else if (joinRoom != null) {
      return joinRoom;
    } else if (increaseMine != null) {
      return increaseMine;
    } else if (increaseAttack != null) {
      return increaseAttack;
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

  factory JsonMessage.welcome() => const JsonMessage(
    welcome: JsonWelcome(),
  );

  factory JsonMessage.update(JsonMatch match) => JsonMessage(
    update: JsonUpdate(match: match),
  );

  factory JsonMessage.laneRewardWon() => const JsonMessage(
    laneRewardWon: JsonLaneRewardWon(),
  );

  factory JsonMessage.laneRewardLost() => const JsonMessage(
    laneRewardLost: JsonLaneRewardLost(),
  );

  factory JsonMessage.laneWon() => const JsonMessage(
    laneWon: JsonLaneWon(),
  );

  factory JsonMessage.laneLost() => const JsonMessage(
    laneLost: JsonLaneLost(),
  );

  factory JsonMessage.unitsLaunched({
    required int laneId,
    required int amount,
    required int direction,
    required int attackLevel,
  }) => JsonMessage(
    unitsLaunched: JsonUnitsLaunched(
      laneId: laneId,
      amount: amount,
      direction: direction,
      attackLevel: attackLevel,
    ),
  );

  factory JsonMessage.joinRoom({
    required String roomId,
    required String playerId,
  }) => JsonMessage(
    joinRoom: JsonJoinRoom(
      roomId: roomId,
      playerId: playerId,
    ),
  );

  factory JsonMessage.increaseMine({
    required String roomId,
  }) => JsonMessage(
    increaseMine: JsonIncreaseMine(
      roomId: roomId,
    ),
  );

  factory JsonMessage.increaseAttack({
    required String roomId,
  }) => JsonMessage(
    increaseAttack: JsonIncreaseAttack(
      roomId: roomId,
    ),
  );

  factory JsonMessage.launchUnits({
    required String roomId,
    required int laneId,
    required int amount,
  }) => JsonMessage(
    launchUnits: JsonLaunchUnits(
      roomId: roomId,
      laneId: laneId,
      amount: amount,
    ),
  );

  Map<String, dynamic> toJson() => _$JsonMessageToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
