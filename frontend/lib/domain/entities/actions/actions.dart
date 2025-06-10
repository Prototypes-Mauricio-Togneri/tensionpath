import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_unit.dart';
import 'package:tensionpath/domain/entities/actions/action_move_unit.dart';
import 'package:tensionpath/domain/entities/location.dart';

class Actions extends Iterable<Action> {
  final List<Action> _actions;

  const Actions(List<Action> actions) : _actions = actions;

  int add(Action action) {
    if (action is ActionMoveUnit) {
      final ActionMoveUnit? removedAction = removeMoveAction(action.origin);
      _actions.add(action);

      return removedAction?.cost ?? 0;
    } else if (action is ActionDeployUnit) {
      final ActionDeployUnit? removedAction = removeDeployAction(action.target);
      final int removedActionLevel = removedAction?.level ?? 0;

      _actions.add(
        ActionDeployUnit(
          playerId: action.playerId,
          target: action.target,
          level: removedActionLevel + action.level,
        ),
      );

      return 0;
    } else {
      throw Exception('Unsupported action type: ${action.runtimeType}');
    }
  }

  ActionMoveUnit? removeMoveAction(Location location) {
    ActionMoveUnit? removed;

    _actions.removeWhere((action) {
      if (action is ActionMoveUnit && action.origin == location) {
        removed = action;
        return true;
      } else {
        return false;
      }
    });

    return removed;
  }

  ActionDeployUnit? removeDeployAction(Location location) {
    ActionDeployUnit? removed;

    _actions.removeWhere((action) {
      if (action is ActionDeployUnit && action.target == location) {
        removed = action;
        return true;
      } else {
        return false;
      }
    });

    return removed;
  }

  bool hasDeployableActionsOn(Location location) => _actions.any(
    (action) => action is ActionDeployUnit && action.target == location,
  );

  void reset() {
    _actions.clear();
  }

  @override
  Iterator<Action> get iterator => _actions.iterator;
}
