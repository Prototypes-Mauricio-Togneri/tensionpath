import 'package:tensionpath/domain/matches/match.dart';
import 'package:tensionpath/domain/types/match_status.dart';

class MatchEngine {
  final Match match;

  double totalTime = 0;
  MatchStatus status;

  MatchEngine._({
    required this.match,
    required this.status,
  });

  factory MatchEngine.create(Match match) {
    return MatchEngine._(
      match: match,
      status: MatchStatus.playing,
    );
  }

  /*JsonMatch json(Player self) {
    final List<JsonPlayer> jsonPlayers = players
        .map((e) => e.json(e == self))
        .toList();
    final List<JsonLane> jsonLanes = lanes.map((e) => e.json()).toList();

    return JsonMatch(
      id: match.id,
      remainingTime: Constants.MATCH_TIMEOUT - totalTime,
      players: jsonPlayers,
      lanes: jsonLanes,
      status: status,
    );
  }

  Lane _lane(int id) {
    if ((id >= 0) && (id < lanes.length)) {
      final Lane lane = lanes[id];

      if (lane.enabled) {
        return lanes[id];
      } else {
        throw JsonMessage.error('Lane with id: $id not enabled');
      }
    } else {
      throw JsonMessage.error('Invalid lane with id: $id');
    }
  }

  void increaseMine(String playerId) {
    final Player player = players.get(playerId);
    player.increaseMine(Constants.MINE_COST);
    _sendUpdate();
  }

  void increaseAttack(String playerId) {
    final Player player = players.get(playerId);
    player.increaseAttack(Constants.ATTACK_COST);
    _sendUpdate();
  }*/

  void launchUnits({
    required String playerId,
    required int laneId,
    required int amount,
  }) {
    /*final Player player = players.get(playerId);

    final Lane lane = _lane(laneId);

    if (amount > 0) {
      final Units units = player.createUnits(amount);
      lane.launchUnits(units);
      match.broadcast(
        JsonMessage.unitsLaunched(
          laneId: laneId,
          amount: amount,
          direction: player.direction,
          attackLevel: player.attackLevel,
        ),
      );
    } else {
      throw JsonMessage.error('Invalid amount: $amount');
    }*/
  }

  void update(double dt) {
    if (status == MatchStatus.playing) {
      totalTime += dt;

      /*for (final Player player in players) {
        player.update(dt);
      }

      final List<LaneUpdate> laneUpdates = [];

      for (final Lane lane in lanes) {
        final List<LaneUpdate> updates = lane.update(
          dt: dt,
          player1: players.list[0],
          player2: players.list[1],
        );
        laneUpdates.addAll(updates);
      }

      if (laneUpdates.isNotEmpty) {
        _sendMatchUpdate();
      }

      for (final LaneUpdate update in laneUpdates) {
        _sendToPlayer(
          player: update.player,
          json: update.message,
        );
      }

      if (!_checkWinnerByPoints()) {
        if (totalTime >= Constants.MATCH_TIMEOUT) {
          _checkWinnerByTerritory();
        }
      }*/
    }
  }

  /*void _sendMatchUpdate() {
    for (final Player player in players) {
      _sendToPlayer(
        player: player,
        json: JsonMessage.update(json(player)),
      );
    }
  }

  bool _checkWinnerByPoints() {
    Player? winner;

    for (final Player player in players) {
      if (player.hasWon) {
        winner = player;
      }
    }

    for (final Player player in players) {
      if (player == winner) {
        player.setStatus(PlayerStatus.won);
      } else {
        player.setStatus(PlayerStatus.lost);
      }
    }

    if (winner != null) {
      status = MatchStatus.finished;
      _sendUpdate();
    }

    return (winner != null);
  }

  void _checkWinnerByTerritory() {
    final Player player1 = players.list[0];
    final Player player2 = players.list[1];

    final int player1Percentage = _getPlayer1Percentage();
    final int player2Percentage = 100 - player1Percentage;

    if (player1Percentage > player2Percentage) {
      player1.setStatus(PlayerStatus.won);
      player2.setStatus(PlayerStatus.lost);
    } else if (player2Percentage > player1Percentage) {
      player1.setStatus(PlayerStatus.lost);
      player2.setStatus(PlayerStatus.won);
    } else {
      player1.setStatus(PlayerStatus.tie);
      player2.setStatus(PlayerStatus.tie);
    }

    status = MatchStatus.finished;
    _sendUpdate();
  }

  int _getPlayer1Percentage() {
    double sum = 0;

    for (final Lane lane in lanes) {
      sum += lane.wall;
    }

    return ((sum / Constants.LANES) * 100).round();
  }

  void _sendUpdate() {
    for (final Player player in players) {
      _sendToPlayer(
        player: player,
        json: JsonMessage.update(json(player)),
      );
    }
  }

  void _sendToPlayer({
    required Player player,
    required JsonMessage json,
  }) => match.direct(
    playerId: player.id,
    json: json,
  );*/
}
