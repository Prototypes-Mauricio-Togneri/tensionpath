import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/presentation/game/game_screen.dart';
import 'package:tensionpath/presentation/lobby/lobby_screen.dart';
import 'package:tensionpath/utils/locator.dart';

class Navigation {
  final Routes routes = Routes();

  static Navigation get get => locator<Navigation>();

  static void pop<T>([T? result]) => get.routes.pop(result);

  static void gameScreen() => get.routes.pushAlone(
        BasicRoute(
          GameScreen.instance(),
          name: 'game',
        ),
      );

  static void lobbyScreen() => get.routes.push(
        BasicRoute(
          LobbyScreen.instance(),
          name: 'lobby',
        ),
      );
}
