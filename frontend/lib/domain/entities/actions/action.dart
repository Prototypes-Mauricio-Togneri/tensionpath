import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/action_type.dart';

abstract class Action {
  final ActionType type;
  final String playerId;

  const Action({required this.type, required this.playerId});

  bool belongsTo(Player player) => playerId == player.id;

  int get cost;
}
