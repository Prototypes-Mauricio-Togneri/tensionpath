import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/actions/actions.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/utils/json.dart';

part 'json_player.g.dart';

@JsonSerializable()
class JsonPlayer {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'userId')
  final String userId;

  @JsonKey(name: 'baseHealth')
  final int baseHealth;

  @JsonKey(name: 'resources')
  final int resources;

  @JsonKey(name: 'status')
  final PlayerStatus status;

  @JsonKey(name: 'turnEndedAt', toJson: dateToJson)
  final DateTime? turnEndedAt;

  @JsonKey(name: 'actions')
  final List<JsonAction> actions;

  JsonPlayer({
    required this.id,
    required this.name,
    required this.userId,
    required this.baseHealth,
    required this.resources,
    required this.status,
    required this.turnEndedAt,
    required this.actions,
  });

  Player object(String userId) => Player(
    id: id,
    name: name,
    isSelf: userId == this.userId,
    actions: Actions(actions.map((a) => a.object).toList()),
    baseHealth: baseHealth,
    resources: resources,
    status: status,
    turnEndedAt: turnEndedAt,
  );

  factory JsonPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerToJson(this);
}
