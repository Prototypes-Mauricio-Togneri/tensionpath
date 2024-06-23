import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/models/room.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/sprites.dart';

class SplashState extends BaseState {
  @override
  Future onLoad() async {
    await Sprites.load();

    Navigation.matchScreen(
      room: Room.empty(),
      battlefield: Battlefield.lanes5(),
    );
  }
}
