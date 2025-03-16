import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/state/game/game_engine.dart';

class MatchComponent extends World {
  MatchComponent();

  @override
  FutureOr onLoad() {
    final GameEngine engine = GameEngineRef.instance;

    add(BattlefieldComponent(engine.battlefield));
    add(ControlsComponent(engine.self));

    return super.onLoad();
  }
}
