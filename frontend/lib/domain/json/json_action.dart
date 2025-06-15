import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_unit.dart';
import 'package:tensionpath/domain/entities/actions/action_move_unit.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/types/action_type.dart';

part 'json_action.g.dart';

@JsonSerializable()
class JsonAction {
  @JsonKey(name: 'type')
  final ActionType type;

  @JsonKey(name: 'playerId')
  final String playerId;

  @JsonKey(name: 'originX')
  final int? originX;

  @JsonKey(name: 'originY')
  final int? originY;

  @JsonKey(name: 'targetX')
  final int targetX;

  @JsonKey(name: 'targetY')
  final int targetY;

  @JsonKey(name: 'level')
  final int? level;

  JsonAction({
    required this.type,
    required this.playerId,
    required this.originX,
    required this.originY,
    required this.targetX,
    required this.targetY,
    required this.level,
  });

  Action get object {
    if (type == ActionType.deploy) {
      return ActionDeployUnit(
        playerId: playerId,
        target: Location(x: targetX, y: targetY),
        level: level!,
      );
    } else if (type == ActionType.move) {
      return ActionMoveUnit(
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
