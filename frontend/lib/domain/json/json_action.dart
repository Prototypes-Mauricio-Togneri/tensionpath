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
  ActionType type;

  @JsonKey(name: 'playerId')
  String playerId;

  @JsonKey(name: 'originX')
  int? originX;

  @JsonKey(name: 'originY')
  int? originY;

  @JsonKey(name: 'targetX')
  int targetX;

  @JsonKey(name: 'targetY')
  int targetY;

  @JsonKey(name: 'amount')
  int? amount;

  JsonAction({
    required this.type,
    required this.playerId,
    required this.originX,
    required this.originY,
    required this.targetX,
    required this.targetY,
    required this.amount,
  });

  Action get object {
    if (type == ActionType.deploy) {
      return ActionDeployUnits(
        playerId: playerId,
        target: Location(x: targetX, y: targetY),
        amount: amount!,
      );
    } else if (type == ActionType.move) {
      return ActionMoveUnits(
        playerId: playerId,
        origin: Location(x: originX!, y: originY!),
        target: Location(x: targetX, y: targetY),
      );
    } else {
      throw Exception('Unsupported action type: $type');
    }
  }

  factory JsonAction.fromJson(Map<String, dynamic> json) =>
      _$JsonActionFromJson(json);

  Map<String, dynamic> toJson() => _$JsonActionToJson(this);
}
