import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_position.dart';

part 'json_platform.g.dart';

@JsonSerializable()
class JsonPlatform {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'owner')
  final String? owner;

  const JsonPlatform({
    required this.id,
    required this.position,
    required this.owner,
  });

  /*String? get owner {
    int player1 = 0;
    int player2 = 0;

    for (final Node node in nodes) {
      if (node.hasUnit) {
        if (node.unit!.player.isPlayer1) {
          player1++;
        } else if (node.unit!.player.isPlayer2) {
          player2++;
        }
      }
    }

    if ((player1 > 0) && (player2 == 0)) {
      return Constants.PLAYER_1;
    } else if ((player2 > 0) && (player1 == 0)) {
      return Constants.PLAYER_2;
    } else if ((player1 > 0) && (player2 > 0)) {
      return '';
    } else {
      return null;
    }
    return null;
  }*/

  factory JsonPlatform.fromJson(Map<String, dynamic> json) =>
      _$JsonPlatformFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlatformToJson(this);
}
