import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_unit.g.dart';

@JsonSerializable()
class JsonUnit {
  @JsonKey(name: 'playerId')
  final String playerId;

  @JsonKey(name: 'level')
  final int level;

  @JsonKey(name: 'type')
  final UnitType type;

  JsonUnit({required this.playerId, required this.level, required this.type});

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
