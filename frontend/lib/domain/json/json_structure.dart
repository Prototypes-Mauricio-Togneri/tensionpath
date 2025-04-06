import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/domain/entities/structures/structure_missile.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

part 'json_structure.g.dart';

@JsonSerializable()
class JsonStructure {
  @JsonKey(name: 'type')
  final StructureType type;

  @JsonKey(name: 'player')
  final String? player;

  const JsonStructure({required this.type, required this.player});

  Structure object(List<Player> players) {
    final Player? structurePlayer = Player.playerById(
      id: player,
      players: players,
    );

    switch (type) {
      case StructureType.launcher:
        return StructureLauncher(structurePlayer: structurePlayer);
      case StructureType.resources:
        return StructureResources();
      case StructureType.missile:
        return StructureMissile();
      case StructureType.platform:
        throw UnimplementedError();
    }
  }

  factory JsonStructure.fromJson(Map<String, dynamic> json) =>
      _$JsonStructureFromJson(json);

  Map<String, dynamic> toJson() => _$JsonStructureToJson(this);
}
