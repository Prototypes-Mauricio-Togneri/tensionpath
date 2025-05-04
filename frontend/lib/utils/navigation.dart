import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/presentation/lobby/lobby_screen.dart';
import 'package:tensionpath/presentation/match/match_screen.dart';
import 'package:tensionpath/utils/locator.dart';

class Navigation {
  final Routes routes = Routes();

  static Navigation get get => locator<Navigation>();

  static BuildContext context() => get.routes.key.currentContext!;

  static void pop<T>([T? result]) => get.routes.pop(result);

  static void lobbyScreen({required Room room, required String playerId}) =>
      get.routes.push(
        BasicRoute(
          LobbyScreen.instance(room: room, playerId: playerId),
          name: 'lobby',
        ),
      );

  static void matchScreen({required String matchId, required String selfId}) =>
      get.routes.pushReplacement(
        BasicRoute(
          MatchScreen.instance(matchId: matchId, selfId: selfId),
          name: 'match',
        ),
      );
}
