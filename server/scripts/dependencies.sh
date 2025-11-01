#!/usr/bin/env bash

set -e

dart pub upgrade
dart pub run dapublock:dapublock.dart .
dart pub run daunused:daunused.dart . "lib/main/*,.dart_tool/*" "main,counterAgainst,stats"
dart pub outdated
dart pub upgrade --major-versions
dart format lib