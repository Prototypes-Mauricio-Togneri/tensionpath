import 'dart:io';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/starter.dart';

void main(List<String> args) {
  final Environment environment = Environment(
    apiKey: Platform.environment['API_KEY'] ?? args[0],
    port: int.parse(Platform.environment['PORT'] ?? args[1]),
    isLocal: (Platform.environment['IS_LOCAL'] ?? args[2]) == 'true',
  );

  final Starter launcher = Starter(environment);
  launcher.start();
}
