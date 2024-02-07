#!/usr/bin/env bash

set -e

flutter pub upgrade
flutter pub pub run dapublock:dapublock.dart .
flutter pub run daunused:daunused.dart . lib/main/main_local.dart lib/main/main_remote.dart lib/build/generate_version.dart .dart_tool/.*
flutter pub outdated
flutter pub upgrade --major-versions
dart format lib