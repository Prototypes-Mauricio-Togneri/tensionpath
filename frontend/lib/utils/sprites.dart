import 'package:flame/components.dart';
import 'package:tensionpath/utils/assets.dart';

class Sprites {
  static late Sprite BATTLEFIELD_LANES_3;
  static late Sprite BATTLEFIELD_LANES_5;
  static late Sprite UNIT_ENEMY;
  static late Sprite UNIT_SELF;
  static late Sprite LAUNCHER_ENEMY;
  static late Sprite LAUNCHER_SELF;
  static late Sprite NODE_ENEMY;
  static late Sprite NODE_NEUTRAL;
  static late Sprite NODE_SELF;
  static late Sprite NODE_ICON_VICTORY;
  static late Sprite NODE_ICON_CREDIT_GENERATOR;
  static late Sprite NODE_ICON_UNIT_GENERATOR;
  static late Sprite NODE_ICON_CHECKPOINT;

  static Future load() async {
    BATTLEFIELD_LANES_3 = await Sprite.load(Assets.IMAGES_BATTLEFIELD_LANES_3);
    BATTLEFIELD_LANES_5 = await Sprite.load(Assets.IMAGES_BATTLEFIELD_LANES_5);
    UNIT_ENEMY = await Sprite.load(Assets.IMAGES_UNIT_ENEMY);
    UNIT_SELF = await Sprite.load(Assets.IMAGES_UNIT_SELF);
    LAUNCHER_ENEMY = await Sprite.load(Assets.IMAGES_LAUNCHER_ENEMY);
    LAUNCHER_SELF = await Sprite.load(Assets.IMAGES_LAUNCHER_SELF);
    NODE_ENEMY = await Sprite.load(Assets.IMAGES_NODE_ENEMY);
    NODE_NEUTRAL = await Sprite.load(Assets.IMAGES_NODE_NEUTRAL);
    NODE_SELF = await Sprite.load(Assets.IMAGES_NODE_SELF);
    NODE_ICON_VICTORY = await Sprite.load(Assets.IMAGES_NODE_ICON_VICTORY);
    NODE_ICON_CREDIT_GENERATOR =
        await Sprite.load(Assets.IMAGES_NODE_ICON_CREDIT_GENERATOR);
    NODE_ICON_UNIT_GENERATOR =
        await Sprite.load(Assets.IMAGES_NODE_ICON_UNIT_GENERATOR);
    NODE_ICON_CHECKPOINT =
        await Sprite.load(Assets.IMAGES_NODE_ICON_CHECKPOINT);
  }
}
