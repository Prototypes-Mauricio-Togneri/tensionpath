# Server

heroku buildpacks:set https://github.com/IreinaMaid150700/heroku-buildpack-dart.git --app tension-path

heroku config:set DART_SDK_URL=https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip --app tension-path