#!/usr/bin/env bash

set -e

flutter pub upgrade
flutter pub run dapublock:dapublock.dart .
flutter pub run daunused:daunused.dart . "lib/main/*,.dart_tool/*,lib/utils/assets.dart" "main,debug,onUncaughtError,isMobileNative,isRelease,isLocal,isRemote,registerPlugins,soundSpeed,pauseMusic,resumeMusic,musicSpeed,damageAgainst"
flutter pub outdated
flutter pub upgrade --major-versions
dart pub global activate flutterfire_cli
flutterfire update
dart format lib