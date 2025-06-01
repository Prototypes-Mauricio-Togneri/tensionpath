#!/usr/bin/env bash

set -e

flutter pub upgrade
flutter pub run dapublock:dapublock.dart .
flutter pub run daunused:daunused.dart lib "lib/main/*" "==,main,build,DURATION_SHORT,DURATION_LONG,debug,isMobileNative,isRelease,isLocal,isRemote,getPath,prepareExternalUrl,containsLocalPoint,onTapUp,onKeyEvent,onDragUpdate,onDestroy"
flutter pub outdated
flutter pub upgrade --major-versions
dart pub global activate flutterfire_cli
flutterfire update
dart format lib