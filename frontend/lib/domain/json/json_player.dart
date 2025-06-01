import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/actions/actions.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';

part 'json_player.g.dart';

@JsonSerializable()
class JsonPlayer {
  @JsonKey(name: 'name')
  final String name;

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

  const JsonPlayer({
    required this.name,
    required this.baseHealth,
    required this.resources,
    required this.status,
    required this.turnEndedAt,
    required this.actions,
  });

  JsonPlayer clone({String? name}) => JsonPlayer(
    name: name ?? this.name,
    baseHealth: baseHealth,
    resources: resources,
    status: status,
    turnEndedAt: turnEndedAt,
    actions: actions,
  );

  Player object({required String id, required bool isSelf}) => Player(
    id: id,
    name: name,
    isSelf: isSelf,
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
