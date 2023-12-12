import 'dart:ui';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/utils/palette.dart';

class Ownership {
  final Node node;
  final double rate;
  double _value = 0;
  Player? _owner;
  Player? _lastTouched;

  Ownership._(
    this.node,
    this.rate,
    this._owner,
  );

  factory Ownership.create({
    required Node node,
    required double rate,
    required Player? owner,
  }) =>
      Ownership._(node, rate, owner);

  Player? get owner => _owner;

  bool get hasTouched => _lastTouched != null;

  bool get hasOwner => _owner != null;

  Color get color {
    if (value > 0) {
      return Player.SELF.color;
    } else if (value < 0) {
      return Player.ENEMY.color;
    } else {
      return Palette.transparent;
    }
  }

  double get value => _value;

  bool isOwner(Player player) => _owner == player;

  void touched(Player player) => _lastTouched = player;

  bool update(double dt) {
    if ((_lastTouched != null) && (_lastTouched != _owner)) {
      _value += (dt * rate) * _lastTouched!.ownershipDirection;
      _value = _value.clamp(-1, 1);

      if ((_value == 1) || (_value == -1)) {
        _owner = _lastTouched!;
        node.onOwnerAssigned(_owner!);
      } else {
        if (_owner != null) {
          node.onOwnerUnassigned(_owner!);
        }

        _owner = null;
      }

      return true;
    }

    return false;
  }
}
