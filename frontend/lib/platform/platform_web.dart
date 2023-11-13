import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:tensionpath/platform/platform_base.dart';

class PlatformMethods extends PlatformMethodsBase {
  @override
  void urlStrategy() {
    setUrlStrategy(EmptyUrlStrategy());
  }
}

class EmptyUrlStrategy extends HashUrlStrategy {
  EmptyUrlStrategy([
    super.platformLocation,
  ]) : _basePath = stripTrailingSlash(extractPathname(checkBaseHref(
          platformLocation.getBaseHref(),
        )));

  final String _basePath;

  @override
  String getPath() => _basePath;

  @override
  String prepareExternalUrl(String internalUrl) => _basePath;
}
