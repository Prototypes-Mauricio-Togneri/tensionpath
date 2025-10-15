import 'package:flutter/foundation.dart';
import 'package:tensionpath/utils/locator.dart';
import 'package:tensionpath/utils/platform.dart';

abstract class Environment {
  String get name;

  bool get isDebug => kDebugMode;

  bool get isRelease => kReleaseMode;

  bool get audioEnabled => true;

  bool get joinTestMatch => false;

  bool get isLocal => name == 'local';

  bool get isRemote => name == 'remote';

  String get serverHost;

  String get host => Platform.isWeb ? 'localhost' : '10.0.2.2';

  Future configure() async {}

  static Environment get get => locator<Environment>();
}
