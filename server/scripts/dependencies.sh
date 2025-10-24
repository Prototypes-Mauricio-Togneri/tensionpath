#!/usr/bin/env bash

set -e

flutter pub upgrade
flutter pub run dapublock:dapublock.dart .
flutter pub run daunused:daunused.dart . "lib/main/*,.dart_tool/*" "main,counterAgainst,stats"
flutter pub outdated
flutter pub upgrade --major-versions
dart format lib