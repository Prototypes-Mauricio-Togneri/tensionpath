import 'dart:io';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/launcher.dart';

void main(List<String> args) {
  environment = Environment(
    apiKey: args[0],
    port: int.parse(args[1]),
    chain: Platform.script.resolve(args[2]).toFilePath(),
    key: Platform.script.resolve(args[3]).toFilePath(),
  );

  final Launcher launcher = Launcher();
  launcher.start();
}
