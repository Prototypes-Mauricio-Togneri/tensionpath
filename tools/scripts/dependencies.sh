#!/usr/bin/env bash

set -e

flutter upgrade
flutter pub run dapublock:dapublock.dart .
flutter pub run daunused:daunused.dart . lib/main/main.dart output/.* .dart_tool/.*
flutter pub outdated
flutter pub upgrade --major-versions
dart format lib