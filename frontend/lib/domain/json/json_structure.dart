import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

part 'json_structure.g.dart';

@JsonSerializable()
class JsonStructure {
  @JsonKey(name: 'type')
  final StructureType type;

  @JsonKey(name: 'playerId')
  final String? playerId;

  @JsonKey(name: 'platformId')
  final String? platformId;

  const JsonStructure({
    required this.type,
    required this.playerId,
    required this.platformId,
  });

  Structure object({
    required Location location,
    required List<Player> players,
  }) => Structure.create(
    structureType: type,
    location: location,
    player: Player.playerById(id: playerId, players: players),
    platformId: platformId,
  );

  factory JsonStructure.fromJson(Map<String, dynamic> json) =>
      _$JsonStructureFromJson(json);

  Map<String, dynamic> toJson() => _$JsonStructureToJson(this);
}
