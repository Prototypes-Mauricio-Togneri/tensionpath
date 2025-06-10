import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/turn.dart';
import 'package:tensionpath/utils/json.dart';

part 'json_turn.g.dart';

@JsonSerializable()
class JsonTurn {
  @JsonKey(name: 'turn')
  int turn;

  @JsonKey(name: 'startedAt', toJson: dateToJson)
  DateTime startedAt;

  JsonTurn({required this.turn, required this.startedAt});

  Turn get object => Turn(turn: turn, startedAt: startedAt);

  factory JsonTurn.fromJson(Map<String, dynamic> json) =>
      _$JsonTurnFromJson(json);

  Map<String, dynamic> toJson() => _$JsonTurnToJson(this);
}
