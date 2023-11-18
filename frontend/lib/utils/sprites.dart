import 'package:flame/components.dart';
import 'package:tensionpath/utils/assets.dart';

class Sprites {
  static late Sprite BATTLEFIELD;
  static late Sprite NODE;
  static late Sprite UNIT;

  static Future load() async {
    Sprites.BATTLEFIELD = await Sprite.load(Assets.IMAGES_BATTLEFIELD);
    Sprites.NODE = await Sprite.load(Assets.IMAGES_NODE);
    Sprites.UNIT = await Sprite.load(Assets.IMAGES_UNIT);
  }
}
