import 'dart:convert';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/services.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  String matchId = 'eU1YjBIWXd2BPzUbrGbK';

  @override
  void onLoad() {
    /*if (Environment.get.isDebug) {
      Delayed.post(() => _onPlay(Constants.PLAYER_1));
    }*/
  }

  void _onPlay(String selfId) =>
      Navigation.matchScreen(matchId: matchId, selfId: selfId);

  void onFullscreen() => SetFullscreen.set();

  Future onCreateMatch() async {
    final String content = await rootBundle.loadString(Assets.TEMPLATES_W9H7);
    final JsonMatch jsonMatch = JsonMatch.fromJson(jsonDecode(content));
    final String matchId = await MatchRepository.create(jsonMatch);
    Navigation.matchScreen(matchId: matchId, selfId: Constants.PLAYER_1);
  }
}
