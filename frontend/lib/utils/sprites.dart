import 'package:flame/components.dart';
import 'package:tensionpath/utils/assets.dart';

class Sprites {
  static late Sprite PLAYER;
  static late Sprite BATTLEFIELD;
  static late Sprite NODE;

  static Future load() async {
    Sprites.PLAYER = await Sprite.load(Assets.IMAGES_PLAYER);
    Sprites.BATTLEFIELD = await Sprite.load(Assets.IMAGES_BATTLEFIELD);
    Sprites.NODE = await Sprite.load(Assets.IMAGES_NODE);
  }
}
