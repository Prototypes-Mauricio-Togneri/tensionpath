import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/update.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';
import 'package:tensionpath/domain/types/match_status.dart';

class Match {
  final DateTime createdAt;
  final Config config;
  final List<Player> players;
  final Battlefield battlefield;
  num elapsedTime = 0;
  MatchStatus _matchStatus = MatchStatus.playing;

  Match({
    required this.createdAt,
    required this.config,
    required this.players,
    required this.battlefield,
  });

  Player get self => players.firstWhere((player) => player.isSelf);

  Player get opponent => players.firstWhere((player) => !player.isSelf);

  bool get isPlaying => _matchStatus == MatchStatus.playing;

  void refresh(MatchUpdate matchUpdate) {
    _matchStatus = matchUpdate.status;
  }

  void update(double dt) {
    if (isPlaying) {
      elapsedTime += dt;
    }
  }

  factory Match.fromJson(JsonMatchStart jsonMatch) => Match(
    createdAt: DateTime.parse(jsonMatch.createdAt),
    config: Config.fromJson(jsonMatch.config),
    players: jsonMatch.players.map(Player.fromJson).toList(),
    battlefield: Battlefield.fromJson(jsonMatch.battlefield),
  );
}
