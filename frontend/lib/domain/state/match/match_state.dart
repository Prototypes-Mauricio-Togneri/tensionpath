import 'dart:convert';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/services.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/json_match.dart';
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
    final JsonMatch json = JsonMatch.fromJson(jsonDecode(data));
    final Match match = json.object(selfId);
    gameComponent = GameComponent(match);
    notify();
  }
}
