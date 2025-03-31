import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  @override
  void onLoad() {
    if (Environment.get.isDebug) {
      Delayed.post(onPlay);
    }
  }

  void onPlay() => Navigation.matchScreen();

  void onFullscreen() => SetFullscreen.set();
}
