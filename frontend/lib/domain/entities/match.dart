import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';

class Match {
  final DateTime createdAt;
  final int maxHarvestersCount;
  final num popcapRate;
  final List<Player> players;
  final Battlefield battlefield;

  const Match({
    required this.createdAt,
    required this.maxHarvestersCount,
    required this.popcapRate,
    required this.players,
    required this.battlefield,
  });

  Player get self => players.firstWhere((player) => player.isSelf);

  Player get opponent => players.firstWhere((player) => !player.isSelf);

  factory Match.fromJson(JsonMatchStart jsonMatch) => Match(
    createdAt: DateTime.parse(jsonMatch.createdAt),
    maxHarvestersCount: jsonMatch.maxHarvestersCount,
    popcapRate: jsonMatch.popcapRate,
    players: jsonMatch.players.map(Player.fromJson).toList(),
    battlefield: Battlefield.fromJson(jsonMatch.battlefield),
  );
}
