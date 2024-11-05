import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';

class MatchComponent extends World {
  final GameState state;

  MatchComponent(this.state);

  @override
  FutureOr onLoad() {
    add(BattlefieldComponent(
      battlefield: state.battlefield,
    ));

    return super.onLoad();
  }
}
