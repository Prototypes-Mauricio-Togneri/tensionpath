import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/domain/entities/structures/structure_missile.dart';
import 'package:tensionpath/domain/entities/structures/structure_platform.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

abstract class Structure {
  final StructureType type;
  final Player? player;

  Structure({required this.type, required this.player});

  bool get hasPlayer => player != null;

  int get visibilityRange => type.visibilityRange;

  bool belongsTo(Player otherPlayer) => otherPlayer.id == player?.id;

  StructureComponent component({
    required Vector2 position,
    required Vector2 size,
  });

  factory Structure.create({
    required StructureType structureType,
    required Player? player,
  }) {
    switch (structureType) {
      case StructureType.launcher:
        return StructureLauncher(player: player!);
      case StructureType.resources:
        return StructureResources();
      case StructureType.missile:
        return StructureMissile();
      case StructureType.platform:
        return StructurePlatform();
    }
  }
}
