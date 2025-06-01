import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_units.dart';
import 'package:tensionpath/domain/entities/actions/action_move_units.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/types/action_type.dart';

part 'json_action.g.dart';

@JsonSerializable()
class JsonAction {
  @JsonKey(name: 'type')
  final ActionType type;

  @JsonKey(name: 'originX')
  final int? originX;

  @JsonKey(name: 'originY')
  final int? originY;

  @JsonKey(name: 'targetX')
  final int targetX;

  @JsonKey(name: 'targetY')
  final int targetY;

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

  Action get object {
    if (type == ActionType.deploy) {
      return ActionDeployUnits(
        target: Location(x: targetX, y: targetY),
        amount: amount!,
      );
    } else if (type == ActionType.move) {
      return ActionMoveUnits(
        origin: Location(x: originX!, y: originY!),
        target: Location(x: targetX, y: targetY),
      );
    } else {
      throw Exception('Unsupported action type: $type');
    }
  }

  factory JsonAction.fromAction(Action action) {
    if (action is ActionDeployUnits) {
      return JsonAction(
        type: action.type,
        originX: null,
        originY: null,
        targetX: action.target.x,
        targetY: action.target.y,
        amount: action.amount,
      );
    } else if (action is ActionMoveUnits) {
      return JsonAction(
        type: action.type,
        originX: action.origin.x,
        originY: action.origin.y,
        targetX: action.target.x,
        targetY: action.target.y,
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
