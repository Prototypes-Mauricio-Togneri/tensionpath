import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/starter.dart';

void main(List<String> args) {
  final Environment environment = Environment(
    apiKey: args[0],
    port: int.parse(args[1]),
    createTestMatch: (args.length > 2) && (args[2] == 'true'),
    showLogs: (args.length > 3) && (args[3] == 'true'),
  );

  final Starter launcher = Starter(environment);
  launcher.start();
}
