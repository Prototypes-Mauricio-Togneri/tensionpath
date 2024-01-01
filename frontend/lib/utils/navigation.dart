import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/models/room.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/presentation/lobby/lobby_screen.dart';
import 'package:tensionpath/presentation/main/main_screen.dart';
import 'package:tensionpath/presentation/match/match_screen.dart';
import 'package:tensionpath/presentation/settings/settings_screen.dart';
import 'package:tensionpath/utils/locator.dart';

class Navigation {
  final Routes routes = Routes();

  static Navigation get get => locator<Navigation>();

  static BuildContext context() => get.routes.key.currentContext!;

  static void pop<T>([T? result]) => get.routes.pop(result);

  static void mainScreen() => get.routes.pushAlone(
        BasicRoute(
          MainScreen.instance(),
          name: 'main',
        ),
      );

  static void settingsScreen(bool pushAlone) {
    final FadeRoute route = FadeRoute(
      SettingsScreen.instance(pushAlone),
      name: 'settings',
    );

    if (pushAlone) {
      get.routes.pushAlone(route);
    } else {
      get.routes.push(route);
    }
  }

  static void lobbyScreen({
    required int version,
    required String matchType,
    required int numberOfPlayers,
  }) =>
      get.routes.push(
        BasicRoute(
          LobbyScreen.instance(
            version: version,
            matchType: matchType,
            numberOfPlayers: numberOfPlayers,
          ),
          name: 'lobby',
        ),
      );

  static void matchScreen({
    required Room room,
    required Battlefield battlefield,
  }) =>
      get.routes.pushReplacement(
        BasicRoute(
          MatchScreen.instance(
            room: room,
            battlefield: battlefield,
          ),
          name: 'match',
        ),
      );
}
