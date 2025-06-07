import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_units.dart';
import 'package:tensionpath/domain/entities/actions/action_move_units.dart';
import 'package:tensionpath/domain/entities/location.dart';

class Actions extends Iterable<Action> {
  final List<Action> _actions;

  const Actions(List<Action> actions) : _actions = actions;

  void add(Action action) {
    if (action is ActionMoveUnits) {
      removeMoveActions(action.origin);
      _actions.add(action);
    } else if (action is ActionDeployUnits) {
      int currentAmount = 0;
      Action? toRemove;

      for (final Action existingAction in _actions) {
        if (existingAction is ActionDeployUnits &&
            existingAction.target == action.target) {
          currentAmount += existingAction.amount;
          toRemove = existingAction;
        }
      }

      if (toRemove != null) {
        _actions.remove(toRemove);
      }

      _actions.add(
        ActionDeployUnits(
          playerId: action.playerId,
          target: action.target,
          amount: currentAmount + action.amount,
        ),
      );
    } else {
      throw Exception('Unsupported action type: ${action.runtimeType}');
    }
  }

  List<Action> removeMoveActions(Location location) {
    final List<Action> removed = _actions
        .where(
          (action) =>
              (action is ActionMoveUnits) && (action.origin == location),
        )
        .toList();

    _actions.removeWhere(
      (action) => (action is ActionMoveUnits) && (action.origin == location),
    );

    return removed;
  }

  List<Action> removeDeployActions(Location location) {
    final List<Action> removed = _actions
        .where(
          (action) =>
              (action is ActionDeployUnits) && (action.target == location),
        )
        .toList();

    _actions.removeWhere(
      (action) => (action is ActionDeployUnits) && (action.target == location),
    );

    return removed;
  }

  void reset() {
    _actions.clear();
  }

  @override
  Iterator<Action> get iterator => _actions.iterator;
}
