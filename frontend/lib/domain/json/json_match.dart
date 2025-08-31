import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'createdAt', toJson: dateToJson)
  final DateTime createdAt;

  @JsonKey(name: 'players')
  final List<JsonPlayer> players;

  @JsonKey(name: 'battlefield')
  final JsonBattlefield battlefield;

  const JsonMatch({
    required this.id,
    required this.createdAt,
    required this.players,
    required this.battlefield,
  });

  int get timeElapsed => DateTime.now().difference(createdAt).inSeconds;

  JsonPlayer get self => players.firstWhere((player) => player.isSelf);

  JsonPlayer get opponent => players.firstWhere((player) => !player.isSelf);

  bool get selfWon => (self.baseHealth > 0) && (opponent.baseHealth <= 0);

  bool get opponentWon => (opponent.baseHealth > 0) && (self.baseHealth <= 0);

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
