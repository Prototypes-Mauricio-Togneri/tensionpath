import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/presentation/home/home_screen.dart';
import 'package:tensionpath/presentation/lobby/lobby_screen.dart';
import 'package:tensionpath/presentation/match/match_screen.dart';
import 'package:tensionpath/presentation/settings/settings_screen.dart';
import 'package:tensionpath/presentation/setup/setup_screen.dart';
import 'package:tensionpath/utils/locator.dart';

class Navigation {
  final Routes routes = Routes();

  static Navigation get get => locator<Navigation>();

  static BuildContext context() => get.routes.key.currentContext!;

  static void pop<T>([T? result]) => get.routes.pop(result);

  static void setupScreen() =>
      get.routes.pushAlone(BasicRoute(SetupScreen.instance(), name: 'setup'));

  static void homeScreen() =>
      get.routes.pushAlone(BasicRoute(HomeScreen.instance(), name: 'home'));

  static void settingsScreen() =>
      get.routes.push(BasicRoute(SettingsScreen.instance(), name: 'settings'));

  static void lobbyScreen(List<UnitType> deck) =>
      get.routes.push(BasicRoute(LobbyScreen.instance(deck), name: 'lobby'));

  static void matchScreen({
    required String host,
    required String matchId,
    required String userId,
  }) => get.routes.pushReplacement(
    BasicRoute(
      MatchScreen.instance(
        host: host,
        matchId: matchId,
        selfId: userId,
      ),
      name: 'match',
    ),
  );
}
