import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/domain/entities/structures/structure_missile.dart';
import 'package:tensionpath/domain/entities/structures/structure_platform.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/json/json_structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

abstract class Structure {
  final StructureType type;
  Player? _player;

  Structure({required this.type, required Player? player}) {
    _player = player;
  }

  bool get hasPlayer => _player != null;

  bool get isPlayer1 => _player?.isPlayer1 ?? false;

  Color? get color => _player?.color;

  int get visibilityRange => type.visibilityRange;

  bool belongsTo(Player player) => _player?.id == player.id;

  void replaceWith(Structure newStructure) {
    _player = newStructure._player;
  }

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

  JsonStructure toJson() => JsonStructure(type: type, player: _player?.id);
}
