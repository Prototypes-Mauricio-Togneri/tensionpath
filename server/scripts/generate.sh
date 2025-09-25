#!/usr/bin/env bash

set -e

flutter pub upgrade
flutter pub run build_runner build --delete-conflicting-outputs
dart format lib

rm -rf ../frontend/lib/domain/json/models/*
rm -rf ../frontend/lib/domain/json/messages/*

cp -r lib/domain/json/models/ ../frontend/lib/domain/json/
cp -r lib/domain/json/messages/ ../frontend/lib/domain/json/

cp lib/domain/types/unit_class.dart ../frontend/lib/domain/types/
cp lib/domain/types/unit_type.dart ../frontend/lib/domain/types/