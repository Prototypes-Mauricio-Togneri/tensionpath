import 'package:tensionpath/domain/types/action_type.dart';

abstract class Action {
  final ActionType type;
  final String playerId;

  const Action({required this.type, required this.playerId});

  int get cost;
}
