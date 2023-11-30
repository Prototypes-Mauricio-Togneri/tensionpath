import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class MainState extends BaseState {
  Future onStart() async {
    await Fullscreen().enable();
    Navigation.matchScreen();
  }
}
