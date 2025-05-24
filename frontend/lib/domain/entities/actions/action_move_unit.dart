import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/node.dart';

class ActionMoveUnit extends Action {
  final Node nodeStart;
  final Node nodeEnd;

  const ActionMoveUnit({required this.nodeStart, required this.nodeEnd});
}
