import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/unit.dart';

part 'json_unit.g.dart';

@JsonSerializable()
class JsonUnit {
  @JsonKey(name: 'playerId')
  String playerId;

  @JsonKey(name: 'level')
  int level;

  JsonUnit({required this.playerId, required this.level});

  Unit object({required Location location, required List<Player> players}) =>
      Unit(
        player: Player.playerById(id: playerId, players: players)!,
        level: level,
        location: location,
      );

  factory JsonUnit.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitToJson(this);
}
