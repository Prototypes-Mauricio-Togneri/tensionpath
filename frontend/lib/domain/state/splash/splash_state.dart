import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/services.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  String matchId = 'bkSVMdZ1UFZRfqCifqzq';

  @override
  void onLoad() {
    /*if (Environment.get.isDebug) {
      Delayed.post(() => onPlay('1'));
    }*/
  }

  void onPlay(String selfId) =>
      Navigation.matchScreen(matchId: matchId, selfId: selfId);

  void onFullscreen() => SetFullscreen.set();

  Future onCreateMatch() async {
    final String content = await rootBundle.loadString('templates/test.json');
    final JsonMatch jsonMatch = JsonMatch.fromJson(jsonDecode(content));
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('matches').doc();
    await docRef.set(jsonMatch.toJson());
    Navigation.matchScreen(matchId: docRef.id, selfId: '1');
  }
}
