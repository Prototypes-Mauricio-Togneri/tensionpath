import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/node.dart';

class ActionDeployUnit extends Action {
  final Node node;

  const ActionDeployUnit({required this.node});
}
