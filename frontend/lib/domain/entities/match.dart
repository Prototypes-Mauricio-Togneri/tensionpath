import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/models/start/json_match.dart';

class Match {
  final DateTime createdAt;
  final List<Player> players;
  final Battlefield battlefield;

  const Match({
    required this.createdAt,
    required this.battlefield,
    required this.players,
  });

  factory Match.fromJson(JsonMatch jsonMatch) => Match(
    createdAt: DateTime.parse(jsonMatch.createdAt),
    battlefield: Battlefield.fromJson(jsonMatch.battlefield),
    players: jsonMatch.players.map(Player.fromJson).toList(),
  );
}
