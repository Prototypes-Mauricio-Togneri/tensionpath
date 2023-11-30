import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/platform.dart';
import 'package:tensionpath/utils/sprites.dart';

class SplashState extends BaseState {
  @override
  Future onLoad() async {
    await Sprites.load();

    if (Platform.isReleaseMode) {
      Delayed.post(Navigation.mainScreen);
    } else {
      Delayed.post(Navigation.matchScreen);
    }
  }
}
