import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_unit.dart';
import 'package:tensionpath/domain/entities/actions/action_move_unit.dart';
import 'package:tensionpath/domain/entities/node.dart';

class Actions {
  final List<Action> _pending = [];

  void add(Action action) {
    if (action is ActionMoveUnit) {
      _removeMoveActions(action.nodeOrigin);
      _pending.add(action);
    } else if (action is ActionDeployUnit) {
      final bool alreadyExists = _pending.any(
        (existingAction) =>
            existingAction is ActionDeployUnit &&
            existingAction.node == action.node,
      );

      if (!alreadyExists) {
        _pending.add(action);
      }
    } else {
      throw Exception('Unsupported action type: ${action.runtimeType}');
    }
  }

  void _removeMoveActions(Node nodeOrigin) => _pending.removeWhere(
    (action) => (action is ActionMoveUnit) && (action.nodeOrigin == nodeOrigin),
  );
}
