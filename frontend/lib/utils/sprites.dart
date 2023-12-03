import 'package:flame/components.dart';
import 'package:tensionpath/utils/assets.dart';

class Sprites {
  static late Sprite BATTLEFIELD3;
  static late Sprite BATTLEFIELD5;
  static late Sprite UNIT_ENEMY;
  static late Sprite UNIT_SELF;
  static late Sprite LAUNCHER_ENEMY;
  static late Sprite LAUNCHER_SELF;
  static late Sprite NODE_ENEMY;
  static late Sprite NODE_NEUTRAL;
  static late Sprite NODE_SELF;
  static late Sprite NODE_ICON_VICTORY;
  static late Sprite NODE_ICON_GENERATOR;

  static Future load() async {
    Sprites.BATTLEFIELD3 = await Sprite.load(Assets.IMAGES_BATTLEFIELD3);
    Sprites.BATTLEFIELD5 = await Sprite.load(Assets.IMAGES_BATTLEFIELD5);
    Sprites.UNIT_ENEMY = await Sprite.load(Assets.IMAGES_UNIT_ENEMY);
    Sprites.UNIT_SELF = await Sprite.load(Assets.IMAGES_UNIT_SELF);
    Sprites.LAUNCHER_ENEMY = await Sprite.load(Assets.IMAGES_LAUNCHER_ENEMY);
    Sprites.LAUNCHER_SELF = await Sprite.load(Assets.IMAGES_LAUNCHER_SELF);
    Sprites.NODE_ENEMY = await Sprite.load(Assets.IMAGES_NODE_ENEMY);
    Sprites.NODE_NEUTRAL = await Sprite.load(Assets.IMAGES_NODE_NEUTRAL);
    Sprites.NODE_SELF = await Sprite.load(Assets.IMAGES_NODE_SELF);
    Sprites.NODE_ICON_VICTORY =
        await Sprite.load(Assets.IMAGES_NODE_ICON_VICTORY);
    Sprites.NODE_ICON_GENERATOR =
        await Sprite.load(Assets.IMAGES_NODE_ICON_GENERATOR);
  }
}
