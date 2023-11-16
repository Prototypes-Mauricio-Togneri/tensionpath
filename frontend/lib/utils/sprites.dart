import 'package:flame/components.dart';
import 'package:tensionpath/utils/assets.dart';

class Sprites {
  static late Sprite PLAYER;

  static Future load() async {
    Sprites.PLAYER = await Sprite.load(Assets.IMAGES_PLAYER);
  }
}
