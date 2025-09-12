import 'dart:io';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/launcher.dart';

void main(List<String> args) {
  final Environment environment = Environment(
    apiKey: Platform.environment['API_KEY'] ?? args[0],
    port: int.parse(Platform.environment['PORT'] ?? args[1]),
  );

  final Launcher launcher = Launcher(environment);
  launcher.start();
}
