import 'package:tensionpath/server/dispatcher.dart';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/handler.dart';
import 'package:tensionpath/server/looper.dart';
import 'package:tensionpath/server/server.dart';
import 'package:tensionpath/utils/logger.dart';

class Launcher {
  final Environment environment;

  const Launcher(this.environment);

  Future start() async {
    Logger.info('Launching server with values:');
    Logger.info('Port: ${environment.port}');
    Logger.info('API Key: ${environment.apiKey}');

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
