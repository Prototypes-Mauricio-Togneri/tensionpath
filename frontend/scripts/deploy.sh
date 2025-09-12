#!/usr/bin/env bash

set -e

flutter clean
flutter build web -t lib/main/main_remote.dart --release

OUTPUT="../backend/public"
rm -r ${OUTPUT}
mkdir ${OUTPUT}

# Fix for assets in wrong folder
mkdir -p build/web/assets/images
cp -r build/web/assets/assets/images/** build/web/assets/images

mkdir -p build/web/assets/templates
cp -r build/web/assets/assets/templates/** build/web/assets/templates

cp -r build/web/** ${OUTPUT}

cd ../backend

firebase use remote
firebase deploy --only hosting
firebase use local

cd ../frontend