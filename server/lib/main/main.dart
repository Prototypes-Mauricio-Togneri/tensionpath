import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/starter.dart';

void main(List<String> args) {
  final Environment environment = Environment(
    apiKey: args[0],
    port: int.parse(args[1]),
    isDebug: (args.length > 2) && (args[2] == 'true'),
  );

  final Starter launcher = Starter(environment);
  launcher.start();
}
