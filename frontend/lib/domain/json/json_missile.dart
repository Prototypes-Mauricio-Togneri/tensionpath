import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/json_platform.dart';

part 'json_missile.g.dart';

@JsonSerializable()
class JsonMissile {
  @JsonKey(name: 'charge')
  double charge;

  @JsonKey(name: 'maxCharge')
  double maxCharge;

  @JsonKey(name: 'bufferCharge')
  double bufferCharge;

  @JsonKey(name: 'platforms')
  final List<JsonPlatform> platforms;

  JsonMissile({
    required this.charge,
    required this.maxCharge,
    required this.bufferCharge,
    required this.platforms,
  });

  String? get owner {
    int player1 = 0;
    int player2 = 0;
    int none = 0;

    for (final JsonPlatform platform in platforms) {
      if (platform.owner == Constants.PLAYER_1) {
        player1++;
      } else if (platform.owner == Constants.PLAYER_2) {
        player2++;
      } else if (platform.owner == null) {
        none++;
      }
    }

    if (none == platforms.length) {
      return null;
    } else if (player1 > player2) {
      return Constants.PLAYER_1;
    } else if (player2 > player1) {
      return Constants.PLAYER_2;
    } else {
      return '';
    }
  }

  factory JsonMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileToJson(this);
}
