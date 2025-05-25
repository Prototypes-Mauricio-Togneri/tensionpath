import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/turn.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';

part 'json_turn_player.g.dart';

@JsonSerializable()
class JsonTurnPlayer {
  @JsonKey(name: 'status')
  final PlayerStatus status;

  @JsonKey(name: 'turnEndedAt', toJson: dateToJson)
  final DateTime? turnEndedAt;

  const JsonTurnPlayer({required this.status, required this.turnEndedAt});

  TurnPlayer get object => TurnPlayer(status: status, turnEndedAt: turnEndedAt);

  factory JsonTurnPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonTurnPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonTurnPlayerToJson(this);
}
