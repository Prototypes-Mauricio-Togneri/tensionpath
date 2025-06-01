import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/types/action_type.dart';

class ActionMoveUnits extends Action {
  final Location origin;
  final Location target;

  const ActionMoveUnits({
    required super.playerId,
    required this.origin,
    required this.target,
  }) : super(type: ActionType.move);
}
