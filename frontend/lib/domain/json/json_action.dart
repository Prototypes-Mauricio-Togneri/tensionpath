import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_units.dart';
import 'package:tensionpath/domain/entities/actions/action_move_units.dart';
import 'package:tensionpath/domain/types/action_type.dart';

part 'json_action.g.dart';

@JsonSerializable()
class JsonAction {
  @JsonKey(name: 'type')
  final ActionType type;

  @JsonKey(name: 'originX')
  final int originX;

  @JsonKey(name: 'originY')
  final int originY;

  @JsonKey(name: 'targetX')
  final int? targetX;

  @JsonKey(name: 'targetY')
  final int? targetY;

  @JsonKey(name: 'amount')
  final int? amount;

  const JsonAction({
    required this.type,
    required this.originX,
    required this.originY,
    required this.targetX,
    required this.targetY,
    required this.amount,
  });

  factory JsonAction.fromAction(Action action) {
    if (action is ActionDeployUnits) {
      return JsonAction(
        type: action.type,
        originX: action.node.location.x,
        originY: action.node.location.y,
        targetX: null,
        targetY: null,
        amount: action.node.units!.amount,
      );
    } else if (action is ActionMoveUnits) {
      return JsonAction(
        type: action.type,
        originX: action.nodeOrigin.location.x,
        originY: action.nodeOrigin.location.y,
        targetX: action.nodeTarget.location.x,
        targetY: action.nodeTarget.location.y,
        amount: null,
      );
    } else {
      throw Exception('Unsupported action type: ${action.runtimeType}');
    }
  }

  factory JsonAction.fromJson(Map<String, dynamic> json) =>
      _$JsonActionFromJson(json);

  Map<String, dynamic> toJson() => _$JsonActionToJson(this);
}
