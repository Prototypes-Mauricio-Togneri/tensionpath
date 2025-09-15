import 'package:tensionpath/server/dispatcher.dart';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/handler.dart';
import 'package:tensionpath/server/looper.dart';
import 'package:tensionpath/server/server.dart';

class Launcher {
  final Environment environment;

  const Launcher(this.environment);

  Future start() async {
    final Dispatcher dispatcher = Dispatcher();
    final Handler handler = Handler(dispatcher);
    final Server server = Server(
      dispatcher: dispatcher,
      handler: handler,
      environment: environment,
    );
    await server.start();

    final Looper looper = Looper(dispatcher);
    await looper.start();
  }
}
