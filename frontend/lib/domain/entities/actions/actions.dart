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

  void reset() {
    _actions.clear();
  }

  @override
  Iterator<Action> get iterator => _actions.iterator;
}
