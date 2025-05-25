import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/turn.dart';
import 'package:tensionpath/domain/json/json_turn_player.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';

part 'json_turn.g.dart';

@JsonSerializable()
class JsonTurn {
  @JsonKey(name: 'turn')
  final int turn;

  @JsonKey(name: 'startedAt', toJson: dateToJson)
  final DateTime startedAt;

  @JsonKey(name: 'player1')
  final JsonTurnPlayer player1;

  @JsonKey(name: 'player2')
  final JsonTurnPlayer player2;

  const JsonTurn({
    required this.turn,
    required this.startedAt,
    required this.player1,
    required this.player2,
  });

  JsonTurn clone({DateTime? startedAt}) => JsonTurn(
    turn: turn,
    startedAt: startedAt ?? this.startedAt,
    player1: player1,
    player2: player2,
  );

  Turn get object => Turn(
    turn: turn,
    startedAt: startedAt,
    player1: player1.object,
    player2: player2.object,
  );

  factory JsonTurn.fromJson(Map<String, dynamic> json) =>
      _$JsonTurnFromJson(json);

  Map<String, dynamic> toJson() => _$JsonTurnToJson(this);
}
