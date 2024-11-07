import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';

class MatchComponent extends World with HasGameRef {
  final GameState state;

  MatchComponent(this.state);

  @override
  FutureOr onLoad() {
    add(BattlefieldComponent(state));

    return super.onLoad();
  }
}
