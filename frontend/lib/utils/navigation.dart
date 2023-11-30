import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/presentation/main/main_screen.dart';
import 'package:tensionpath/presentation/match/match_screen.dart';
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

  static void matchScreen(Battlefield battlefield) => get.routes.pushAlone(
        BasicRoute(
          MatchScreen.instance(battlefield),
          name: 'match',
        ),
      );
}
