import 'package:tensionpath/battles/battle_manager.dart';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/handler.dart';
import 'package:tensionpath/server/looper.dart';
import 'package:tensionpath/server/server.dart';

class Launcher {
  final Environment environment;

  Launcher(this.environment);

  Future start() async {
    final BattleManager battleManager = BattleManager();
    final Handler handler = Handler(battleManager);
    final Looper looper = Looper(battleManager);
    final Server server = Server(
      battleManager: battleManager,
      handler: handler,
      environment: environment,
    );
    await server.start();
    await looper.start();
  }
}
