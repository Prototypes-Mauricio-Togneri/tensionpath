import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units.dart';

part 'json_units.g.dart';

@JsonSerializable()
class JsonUnits {
  @JsonKey(name: 'player')
  final String player;

  @JsonKey(name: 'amount')
  final int amount;

  @JsonKey(name: 'moveToX')
  final int? moveToX;

  @JsonKey(name: 'moveToY')
  final int? moveToY;

  const JsonUnits({
    required this.player,
    required this.amount,
    required this.moveToX,
    required this.moveToY,
  });

  Units object({required Location location, required List<Player> players}) =>
      Units(
        player: Player.playerById(id: player, players: players)!,
        amount: amount,
        location: location,
        moveTo: ((moveToX != null) && (moveToY != null))
            ? Location(x: moveToX!, y: moveToY!)
            : null,
      );

  factory JsonUnits.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitsToJson(this);
}
