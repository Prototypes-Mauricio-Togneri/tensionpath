import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  String matchId = 'bkSVMdZ1UFZRfqCifqzq';

  @override
  void onLoad() {
    if (Environment.get.isDebug) {
      Delayed.post(() => onPlay('2'));
    }
  }

  void onPlay(String selfId) =>
      Navigation.matchScreen(matchId: matchId, selfId: selfId);

  void onFullscreen() => SetFullscreen.set();
}
