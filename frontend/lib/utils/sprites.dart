import 'package:flame/components.dart';
import 'package:tensionpath/utils/assets.dart';

class Sprites {
  static late Sprite BATTLEFIELD;
  static late Sprite NODE;
  static late Sprite UNIT_SELF;
  static late Sprite UNIT_ENEMY;

  static Future load() async {
    Sprites.BATTLEFIELD = await Sprite.load(Assets.IMAGES_BATTLEFIELD);
    Sprites.NODE = await Sprite.load(Assets.IMAGES_NODE);
    Sprites.UNIT_SELF = await Sprite.load(Assets.IMAGES_UNIT_SELF);
    Sprites.UNIT_ENEMY = await Sprite.load(Assets.IMAGES_UNIT_ENEMY);
  }
}
