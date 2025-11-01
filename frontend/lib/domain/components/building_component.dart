import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/shot_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/building.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';

class BuildingComponent extends SpriteComponent {
  final Building building;
  final NodeComponent nodeComponent;

  BuildingComponent({
    required super.position,
    required super.size,
    required this.building,
    required this.nodeComponent,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       );

  Player get player => building.player;

  @override
  bool containsLocalPoint(Vector2 point) => Dimensions.pointInCircle(
    point: point,
    size: size,
  );

  bool belongsTo(Player player) => player.id == this.player.id;

  @override
  FutureOr onLoad() async {
    if (player.isPlayer1) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_BUILDING_1);
    } else if (player.isPlayer2) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_BUILDING_2);
    }

    add(
      BuildingImageComponent(
        building: building,
        nodeComponent: nodeComponent,
        position: size / 2,
        size: size * 0.4,
      ),
    );

    return super.onLoad();
  }

  void onUnitAttack({
    required UnitComponent attackerUnit,
    required num damage,
  }) {
    final ShotToBaseComponent shotComponent = ShotToBaseComponent(
      position: Vector2.zero(),
      size: attackerUnit.size / 30,
      attackerUnit: attackerUnit,
      targetBase: this,
      damage: damage,
    );
    match.add(shotComponent);
  }
}

class BuildingImageComponent extends SpriteComponent with HasVisibility {
  final Building building;
  final NodeComponent nodeComponent;

  BuildingImageComponent({
    required this.building,
    required this.nodeComponent,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    if (building.type == BuildingType.main) {
      sprite = await Sprite.load(Assets.IMAGES_BUILDINGS_MAIN_ON);
    } else if (building.type == BuildingType.barracks) {
      sprite = await Sprite.load(Assets.IMAGES_BUILDINGS_BARRACKS_ON);
    } else if (building.type == BuildingType.factory) {
      sprite = await Sprite.load(Assets.IMAGES_BUILDINGS_FACTORY_ON);
    } else if (building.type == BuildingType.airfield) {
      sprite = await Sprite.load(Assets.IMAGES_BUILDINGS_AIRFIELD_ON);
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    isVisible = building.isUnlocked && nodeComponent.isRevealed;
  }
}
