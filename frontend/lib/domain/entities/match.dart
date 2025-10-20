import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';

class Match {
  final DateTime createdAt;
  final Config config;
  final List<Player> players;
  final Battlefield battlefield;

  const Match({
    required this.createdAt,
    required this.config,
    required this.players,
    required this.battlefield,
  });

  Player get self => players.firstWhere((player) => player.isSelf);

  Player get opponent => players.firstWhere((player) => !player.isSelf);

  factory Match.fromJson(JsonMatchStart jsonMatch) => Match(
    createdAt: DateTime.parse(jsonMatch.createdAt),
    config: Config.fromJson(jsonMatch.config),
    players: jsonMatch.players.map(Player.fromJson).toList(),
    battlefield: Battlefield.fromJson(jsonMatch.battlefield),
  );
}
