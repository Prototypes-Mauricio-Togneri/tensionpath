#!/usr/bin/env bash

set -e

X=$(grep '^version:' pubspec.yaml | sed -E 's/version: ([0-9.]+)\+([0-9]+)/\1/')
Y=$(grep '^version:' pubspec.yaml | sed -E 's/version: ([0-9.]+)\+([0-9]+)/\2/')

cat > lib/utils/version.dart <<EOF
class Version {
  static const String version = '$X';
  static const String build = '$Y';
}
EOF