import 'dart:convert';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/services.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  String matchId = 'eU1YjBIWXd2BPzUbrGbK';

  @override
  void onLoad() {
    if (Environment.get.isDebug) {
      Delayed.post(() => onPlay('1'));
    }
  }

  void onPlay(String selfId) =>
      Navigation.matchScreen(matchId: matchId, selfId: selfId);

  void onFullscreen() => SetFullscreen.set();

  Future onCreateMatch() async {
    final String content = await rootBundle.loadString('templates/test.json');
    final JsonMatch jsonMatch = JsonMatch.fromJson(jsonDecode(content));
    final String matchId = await MatchRepository.create(jsonMatch);
    Navigation.matchScreen(matchId: matchId, selfId: '1');
  }
}
