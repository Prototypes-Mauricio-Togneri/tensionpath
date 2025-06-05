import 'dart:ui';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/actions.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final String name;
  final bool isSelf;
  final Actions actions;
  late int _baseHealth;
  late int _resources;
  late PlayerStatus _status;
  late DateTime? _turnEndedAt;

  Player({
    required this.id,
    required this.name,
    required this.isSelf,
    required this.actions,
    required int baseHealth,
    required int resources,
    required PlayerStatus status,
    required DateTime? turnEndedAt,
  }) {
    _baseHealth = baseHealth;
    _resources = resources;
    _status = status;
    _turnEndedAt = turnEndedAt;
  }

  int get baseHealth => _baseHealth;

  int get resources => _resources;

  bool get isPlayer1 => id == Constants.PLAYER_1;

  bool get isPlayer2 => id == Constants.PLAYER_2;

  Color get color => isPlayer1 ? Palette.PLAYER_1 : Palette.PLAYER_2;

  PlayerStatus get status => _status;

  DateTime? get turnEndedAt => _turnEndedAt;

  bool hasResources(int value) => resources >= value;

  void setWaiting() {
    _status = PlayerStatus.waiting;
  }

  void spendResources(int value) {
    if (hasResources(value)) {
      _resources -= value;
    }
  }

  void replaceWith(Player newPlayer) {
    _baseHealth = newPlayer.baseHealth;
    _resources = newPlayer.resources;
    _status = newPlayer.status;
    _turnEndedAt = newPlayer.turnEndedAt;

    if (newPlayer.actions.isEmpty) {
      actions.reset();
    }
  }

  void addAction(Action action) {
    actions.add(action);
  }

  static Player? playerById({
    required String? id,
    required List<Player> players,
  }) {
    if (id != null) {
      for (final Player player in players) {
        if (player.id == id) {
          return player;
        }
      }
    }

    return null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is! Player) {
      return false;
    } else {
      return other.id == id;
    }
  }

  @override
  int get hashCode => id.toString().hashCode;
}
