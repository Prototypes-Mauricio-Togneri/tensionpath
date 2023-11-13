import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/sprites.dart';

class SplashState extends BaseState {
  @override
  Future onLoad() async {
    await Sprites.load();
    Delayed.post(Navigation.mainScreen);
  }
}
