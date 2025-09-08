import 'package:tensionpath/rooms/rooms_manager.dart';
import 'package:tensionpath/server/environment.dart';
import 'package:tensionpath/server/handler.dart';
import 'package:tensionpath/server/looper.dart';
import 'package:tensionpath/server/server.dart';

class Launcher {
  final Environment environment;

  Launcher(this.environment);

  Future start() async {
    final RoomsManager roomsManager = RoomsManager();
    final Handler handler = Handler(roomsManager);
    final Looper looper = Looper(roomsManager);
    final Server server = Server(
      roomsManager: roomsManager,
      handler: handler,
      environment: environment,
    );
    await server.start();
    await looper.start();
  }
}
