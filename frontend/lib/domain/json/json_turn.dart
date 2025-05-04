import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/turn.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';

part 'json_turn.g.dart';

@JsonSerializable()
class JsonTurn {
  @JsonKey(name: 'turn')
  final int turn;

  @JsonKey(name: 'startedAt', toJson: dateToJson)
  final DateTime startedAt;

  @JsonKey(name: 'player')
  final String player;

  const JsonTurn({
    required this.turn,
    required this.startedAt,
    required this.player,
  });

  JsonTurn clone({DateTime? startedAt}) => JsonTurn(
    turn: turn,
    startedAt: startedAt ?? this.startedAt,
    player: player,
  );

  Turn get object => Turn(turn: turn, startedAt: startedAt, player: player);

  factory JsonTurn.fromJson(Map<String, dynamic> json) =>
      _$JsonTurnFromJson(json);

  Map<String, dynamic> toJson() => _$JsonTurnToJson(this);
}
