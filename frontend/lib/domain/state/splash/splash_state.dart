import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  @override
  void onLoad() => Navigation.matchScreen(
        battlefield: Battlefield.vector(),
      );
}
