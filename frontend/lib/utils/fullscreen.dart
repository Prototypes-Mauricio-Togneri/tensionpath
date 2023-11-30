import 'package:tensionpath/platform/platform_mobile.dart'
    if (dart.library.html) 'package:tension_tunnel/platform/platform_web.dart';

class Fullscreen {
  void enable() {
    PlatformMethods().webFullscreen();
  }
}
