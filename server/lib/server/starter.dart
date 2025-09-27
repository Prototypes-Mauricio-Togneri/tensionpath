import 'package:tensionpath/server/dispatcher.dart';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/handler.dart';
import 'package:tensionpath/server/looper.dart';
import 'package:tensionpath/server/server.dart';
import 'package:tensionpath/utils/logger.dart';

class Starter {
  final Environment environment;

  const Starter(this.environment);

  Future start() async {
    Logger.initialize(environment);
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
