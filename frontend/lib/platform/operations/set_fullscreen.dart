import 'package:tensionpath/platform/platform_mobile.dart'
    if (dart.library.js_interop) 'package:tensionpath/platform/platform_web.dart';

class SetFullscreen {
  static void set() => PlatformMethods().webFullscreen();
}
