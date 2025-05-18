import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/structures/structure_launcher_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructureLauncher extends Structure {
  final Player player;

  StructureLauncher({required super.location, required this.player})
    : super(type: StructureType.launcher);

  @override
  String? get getPlayerId => player.id;

  @override
  bool belongsTo(Player otherPlayer) => otherPlayer.id == player.id;

  @override
  StructureComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  }) => StructureLauncherComponent(
    node: node,
    structure: this,
    position: position,
    size: size,
  );
}
