import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  @override
  void onLoad() => Delayed.post(Navigation.mainScreen);
}
