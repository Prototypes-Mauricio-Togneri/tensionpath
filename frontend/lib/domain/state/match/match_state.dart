import 'dart:convert';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/services.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/json/game/json_match.dart';
import 'package:tensionpath/utils/assets.dart';

class MatchState extends BaseState {
  final String matchId;
  final String selfId;
  GameComponent? gameComponent;

  MatchState({required this.matchId, required this.selfId});

  bool get isInitialized => gameComponent != null;

  @override
  Future onLoad() async {
    final String data = await rootBundle.loadString(Assets.TEMPLATES_W9H7);
    final JsonMatch match = JsonMatch.fromJson(jsonDecode(data));
    gameComponent = GameComponent(match);
    notify();
  }
}
