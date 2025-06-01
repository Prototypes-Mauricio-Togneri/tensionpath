import 'package:tensionpath/domain/types/action_type.dart';

class Action {
  final ActionType type;
  final String playerId;

  const Action({required this.type, required this.playerId});
}
