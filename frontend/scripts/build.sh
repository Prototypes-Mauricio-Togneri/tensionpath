#!/usr/bin/env bash

set -e

BASE_DIR=`dirname $0`
${BASE_DIR}/version.sh

flutter clean
flutter build web --wasm -t lib/main/main_remote.dart --release

OUTPUT="../backend/public"
rm -r ${OUTPUT}
mkdir ${OUTPUT}

# Fix for assets in wrong folder
#mkdir -p build/web/assets/images
#cp -r build/web/assets/assets/images/** build/web/assets/images

cp -r build/web/** ${OUTPUT}

cd ../backend

cp ./public/version.json ./functions/static/frontend

firebase use remote
firebase deploy
firebase use local

cd ../frontend