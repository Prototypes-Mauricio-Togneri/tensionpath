import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/turn.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';

part 'json_turn.g.dart';

@JsonSerializable()
class JsonTurn {
  @JsonKey(name: 'turn')
  final int turn;

  @JsonKey(name: 'startedAt', toJson: dateToJson)
  final DateTime startedAt;

  const JsonTurn({required this.turn, required this.startedAt});

  JsonTurn clone({DateTime? startedAt}) =>
      JsonTurn(turn: turn, startedAt: startedAt ?? this.startedAt);

  Turn get object => Turn(turn: turn, startedAt: startedAt);

  factory JsonTurn.fromJson(Map<String, dynamic> json) =>
      _$JsonTurnFromJson(json);

  Map<String, dynamic> toJson() => _$JsonTurnToJson(this);
}
