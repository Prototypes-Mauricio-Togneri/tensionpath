import 'package:tensionpath/domain/state/game/players/player.dart';

class SelfPlayer extends Player {
  SelfPlayer({
    required super.id,
    required super.ownershipDirection,
    required super.baseCreditsRate,
  });
}
