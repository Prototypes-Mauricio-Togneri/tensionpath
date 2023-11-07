#!/usr/bin/env bash

set -e

flutter clean
flutter build web -t lib/main/main.dart --web-renderer canvaskit

OUTPUT="../backend/public"
rm -r ${OUTPUT}
mkdir ${OUTPUT}
cp -r build/web/** ${OUTPUT}

cd ../backend

firebase use remote
firebase deploy
firebase use local

cd ../frontend