import 'dart:ui';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  Size? size;

  void setSize(Size size) {
    this.size = size;
    Delayed.post(onPlay);
  }

  void onPlay() => Navigation.matchScreen(size!);
}
