import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/domain/entities/structures/structure_pad.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_position.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

abstract class Structure {
  final StructureType type;
  final JsonPosition position;

  Structure({required this.type, required this.position});

  int get visibilityRange => type.visibilityRange;

  String? get getPlayerId => null;

  String? get getPlatformId => null;

  bool belongsTo(JsonPlayer otherPlayer) => false;

  void replaceWith(Structure newStructure) {}

  StructureComponent component({
    required Vector2 position,
    required Vector2 size,
  });

  factory Structure.create({
    required StructureType structureType,
    required JsonPosition position,
    required JsonPlayer? player,
    required String? platformId,
  }) {
    switch (structureType) {
      case StructureType.launcher:
        return StructureLauncher(position: position, player: player!);
      case StructureType.pad:
        return StructurePad(position: position, platformId: platformId!);
    }
  }
}
