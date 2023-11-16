import 'package:flame/components.dart';
import 'package:tensionpath/utils/assets.dart';

class Sprites {
  static late Sprite PLAYER;
  static late Sprite MAP;

  static Future load() async {
    Sprites.PLAYER = await Sprite.load(Assets.IMAGES_PLAYER);
    Sprites.MAP = await Sprite.load(Assets.IMAGES_MAP);
  }
}
