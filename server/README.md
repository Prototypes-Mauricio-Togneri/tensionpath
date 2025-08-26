# Server

heroku git:remote --app tension-path

heroku config:set PUBSPEC_PATH=server/pubspec.yaml

heroku logs --tail
