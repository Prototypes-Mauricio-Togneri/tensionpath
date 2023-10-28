import 'package:tensionbase/rooms/rooms_manager.dart';
import 'package:tensionbase/server/handler.dart';
import 'package:tensionbase/server/looper.dart';
import 'package:tensionbase/server/server.dart';

Future main(List<String> args) async {
  final RoomsManager roomsManager = RoomsManager();
  final Handler handler = Handler(roomsManager);
  final Looper looper = Looper(roomsManager);

  final int port = int.parse(args[0]);
  final Server server = Server(roomsManager, handler);
  await server.start(port);

  looper.start();
}
