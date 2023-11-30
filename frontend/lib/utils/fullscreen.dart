import 'package:tensionpath/platform/platform_mobile.dart'
    if (dart.library.html) 'package:tensionpath/platform/platform_web.dart';

class Fullscreen {
  Future? enable() => PlatformMethods().webFullscreen();
}
