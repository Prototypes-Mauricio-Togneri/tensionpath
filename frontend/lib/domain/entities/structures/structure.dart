import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/domain/entities/structures/structure_missile.dart';
import 'package:tensionpath/domain/entities/structures/structure_pad.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

abstract class Structure {
  final StructureType type;
  final Location location;

  Structure({required this.type, required this.location});

  int get visibilityRange => type.visibilityRange;

  bool belongsTo(Player otherPlayer) => false;

  bool get isObstacle => type.isObstacle;

  void replaceWith(Structure newStructure) {}

  factory Structure.create({
    required StructureType structureType,
    required Location location,
    required Player? player,
    required String? platformId,
  }) {
    switch (structureType) {
      case StructureType.launcher:
        return StructureLauncher(location: location, player: player!);
      case StructureType.resources:
        return StructureResources(location: location);
      case StructureType.missile:
        return StructureMissile(location: location);
      case StructureType.pad:
        return StructurePad(location: location, platformId: platformId!);
    }
  }
}
