#!/usr/bin/env bash

set -e

flutter pub upgrade
flutter pub run dapublock:dapublock.dart .
flutter pub run daunused:daunused.dart lib "lib/main/*" "DURATION_MEDIUM,DURATION_LONG,debug,isDebug,isMobileNative,isLocal,isRemote,onUncaughtError,getNodeAtLocation"
flutter pub outdated
flutter pub upgrade --major-versions
dart pub global activate flutterfire_cli
flutterfire update
dart format lib