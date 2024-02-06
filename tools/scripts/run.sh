#!/usr/bin/env bash

set -e

dart lib/main.dart
#cp -r ./output/** ../frontend/assets/models
cd ../frontend
dart format lib