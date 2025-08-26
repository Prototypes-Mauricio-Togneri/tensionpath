# Server

heroku buildpacks:set https://github.com/igrigorik/heroku-buildpack-dart --app tension-path

heroku config:set PUBSPEC_PATH=frontend/pubspec.yaml --app tension-path

heroku config:set DART_SDK_URL=https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip --app tension-path
