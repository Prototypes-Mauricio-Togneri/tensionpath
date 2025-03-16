import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class MatchComponent extends World {
  final Player self;
  final Battlefield battlefield;

  MatchComponent({required this.self, required this.battlefield});

  @override
  FutureOr onLoad() {
    add(BattlefieldComponent(battlefield));
    add(ControlsComponent(self));

    return super.onLoad();
  }
}
