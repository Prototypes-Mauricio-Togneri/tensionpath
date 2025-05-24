import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/node.dart';

class ActionMoveUnit extends Action {
  final Node nodeOrigin;
  final Node nodeTarget;

  const ActionMoveUnit({required this.nodeOrigin, required this.nodeTarget});
}
