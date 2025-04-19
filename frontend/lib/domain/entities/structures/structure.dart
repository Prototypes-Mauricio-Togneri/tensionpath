import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/domain/entities/structures/structure_missile.dart';
import 'package:tensionpath/domain/entities/structures/structure_platform.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

abstract class Structure {
  final StructureType type;
  final Location location;
  final Player? player;

  const Structure({
    required this.type,
    required this.location,
    required this.player,
  });

  bool get hasPlayer => player != null;

  int get visibilityRange => type.visibilityRange;

  bool belongsTo(Player otherPlayer) => otherPlayer.id == player?.id;

  StructureComponent component({
    required Vector2 position,
    required Vector2 size,
  });

  factory Structure.create({
    required StructureType structureType,
    required Node node,
    required Player? player,
  }) {
    switch (structureType) {
      case StructureType.launcher:
        return StructureLauncher(location: node.location, player: player!);
      case StructureType.resources:
        return StructureResources(location: node.location);
      case StructureType.missile:
        return StructureMissile(location: node.location);
      case StructureType.platform:
        return StructurePlatform(location: node.location);
    }
  }
}
