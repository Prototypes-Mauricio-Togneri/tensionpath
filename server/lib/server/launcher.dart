import 'package:tensionpath/domain/matches/match_manager.dart';
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

    final MatchManager matchManager = MatchManager();
    final Handler handler = Handler(matchManager);
    final Server server = Server(
      matchManager: matchManager,
      handler: handler,
      environment: environment,
    );
    await server.start();

    final Looper looper = Looper(matchManager);
    await looper.start();
  }
}
