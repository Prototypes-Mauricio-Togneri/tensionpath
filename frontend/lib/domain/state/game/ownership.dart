import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';

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

  bool get hasOwner => _owner != null;

  bool isOwner(Player player) => _owner == player;

  void touched(Player player) => _lastTouched = player;

  bool update(double dt) {
    if ((_lastTouched != null) &&
        (_lastTouched != _owner) &&
        (_value < 1) &&
        (_value > -1)) {
      _value += (dt * rate) * _lastTouched!.ownershipDirection;

      if ((_value >= 1) || (_value < -1)) {
        final Player? previousOwner = _owner;
        final Player newOwner = _lastTouched!;

        _owner = newOwner;

        node.onNewOwner(
          previousOwner: previousOwner,
          newOwner: newOwner,
        );

        return true;
      }
    }

    return false;
  }
}
