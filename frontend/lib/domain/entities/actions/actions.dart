import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_units.dart';
import 'package:tensionpath/domain/entities/actions/action_move_units.dart';
import 'package:tensionpath/domain/entities/location.dart';

class Actions extends Iterable<Action> {
  final List<Action> _actions;

  const Actions(List<Action> actions) : _actions = actions;

  int add(Action action) {
    if (action is ActionMoveUnits) {
      final ActionMoveUnits? removedAction = removeMoveAction(action.origin);
      _actions.add(action);

      return removedAction?.cost ?? 0;
    } else if (action is ActionDeployUnits) {
      final ActionDeployUnits? removedAction = removeDeployAction(
        action.target,
      );
      final int removedActionAmount = removedAction?.amount ?? 0;

      _actions.add(
        ActionDeployUnits(
          playerId: action.playerId,
          target: action.target,
          amount: removedActionAmount + action.amount,
        ),
      );

      return 0;
    } else {
      throw Exception('Unsupported action type: ${action.runtimeType}');
    }
  }

  ActionMoveUnits? removeMoveAction(Location location) {
    ActionMoveUnits? removed;

    _actions.removeWhere((action) {
      if (action is ActionMoveUnits && action.origin == location) {
        removed = action;
        return true;
      } else {
        return false;
      }
    });

    return removed;
  }

  ActionDeployUnits? removeDeployAction(Location location) {
    ActionDeployUnits? removed;

    _actions.removeWhere((action) {
      if (action is ActionDeployUnits && action.target == location) {
        removed = action;
        return true;
      } else {
        return false;
      }
    });

    return removed;
  }

  bool hasDeployableActionsOn(Location location) => _actions.any(
    (action) => action is ActionDeployUnits && action.target == location,
  );

  void reset() {
    _actions.clear();
  }

  @override
  Iterator<Action> get iterator => _actions.iterator;
}
