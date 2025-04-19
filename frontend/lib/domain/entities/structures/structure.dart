import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/domain/entities/structures/structure_missile.dart';
import 'package:tensionpath/domain/entities/structures/structure_platform.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

abstract class Structure {
  final StructureType type;
  final Location location;
  late Player? _player;

  Structure({
    required this.type,
    required this.location,
    required Player? player,
  }) {
    _player = player;
  }

  bool get hasPlayer => _player != null;

  Player? get player => _player;

  int get visibilityRange => type.visibilityRange;

  bool belongsTo(Player otherPlayer) => otherPlayer.id == _player?.id;

  void replaceWith(Structure structure) {
    _player = structure._player;
  }

  StructureComponent component({
    required Vector2 position,
    required Vector2 size,
  });

  factory Structure.create({
    required StructureType structureType,
    required Location location,
    required Player? player,
  }) {
    switch (structureType) {
      case StructureType.launcher:
        return StructureLauncher(location: location, player: player!);
      case StructureType.resources:
        return StructureResources(location: location);
      case StructureType.missile:
        return StructureMissile(location: location);
      case StructureType.platform:
        return StructurePlatform(location: location);
    }
  }
}
