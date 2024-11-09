import 'dart:ui';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/utils/palette.dart';

class Ownership {
  final double captureRate;
  double _value = 0;
  Player? _owner;
  Player? _lastTouched;

  Ownership({required this.captureRate});

  Player? get owner => _owner;

  bool get hasTouched => _lastTouched != null;

  bool get hasOwner => _owner != null;

  double get ownershipValue => _value;

  Color get color {
    if (ownershipValue > 0) {
      return Player.SELF.color;
    } else if (ownershipValue < 0) {
      return Player.ENEMY.color;
    } else {
      return Palette.transparent;
    }
  }

  bool isOwner(Player player) => _owner == player;

  void onTouched(Unit unit) => _lastTouched = unit.owner;

  void update(double dt) {
    if ((_lastTouched != null) && (_lastTouched != _owner)) {
      _value += (dt * captureRate) * _lastTouched!.ownershipDirection;
      _value = _value.clamp(-1, 1);

      if ((_value == 1) || (_value == -1)) {
        _owner = _lastTouched!;
        onOwnerAssigned(_owner!);
      } else {
        if (_owner != null) {
          onOwnerUnassigned(_owner!);
        }

        _owner = null;
      }
    }
  }

  void onOwnerAssigned(Player owner) {}

  void onOwnerUnassigned(Player owner) {}
}
