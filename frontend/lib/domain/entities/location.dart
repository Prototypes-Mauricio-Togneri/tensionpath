import 'package:tensionpath/domain/entities/localizable.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

class Location {
  final int x;
  final int y;

  const Location({required this.x, required this.y});

  String get id => '$x,$y';

  int distance(Localizable localizable) {
    final Location location = localizable.getLocation;
    final double distance =
        ((x - location.x).abs() +
            (x + y - location.x - location.y).abs() +
            (y - location.y).abs()) /
        2;

    return distance.toInt().abs();
  }

  bool isValidTarget({required Player player, required Localizable target}) {
    if (x == target.getLocation.x) {
      // Move vertically
      if (player.isPlayer1) {
        return y > target.getLocation.y;
      } else {
        return y < target.getLocation.y;
      }
    } else if (y == target.getLocation.y) {
      // Move diagonally
      if (player.isPlayer1) {
        return x > target.getLocation.x;
      } else {
        return x < target.getLocation.x;
      }
    } else if (x - target.getLocation.x == target.getLocation.y - y) {
      // Move diagonally
      if (player.isPlayer1) {
        return y > target.getLocation.y;
      } else {
        return y < target.getLocation.y;
      }
    }

    return false;
  }

  List<Location> pathNodes({
    required Player player,
    required Localizable target,
  }) {
    final List<Location> result = [];

    if (x == target.getLocation.x) {
      // Move vertically
      if (player.isPlayer1) {
        for (int i = 1; i <= (y - target.getLocation.y); i++) {
          result.add(Location(x: x, y: y - i));
        }
      } else {
        for (int i = 1; i <= (target.getLocation.y - y); i++) {
          result.add(Location(x: x, y: y + i));
        }
      }
    } else if (y == target.getLocation.y) {
      // Move diagonally
      if (player.isPlayer1) {
        for (int i = 1; i <= (x - target.getLocation.x); i++) {
          result.add(Location(x: x - i, y: y));
        }
      } else {
        for (int i = 1; i <= (target.getLocation.x - x); i++) {
          result.add(Location(x: x + i, y: y));
        }
      }
    } else if (x - target.getLocation.x == target.getLocation.y - y) {
      // Move diagonally
      if (player.isPlayer1) {
        for (int i = 1; i <= (y - target.getLocation.y); i++) {
          result.add(Location(x: x + i, y: y - i));
        }
      } else {
        for (int i = 1; i <= (target.getLocation.y - y); i++) {
          result.add(Location(x: x - i, y: y + i));
        }
      }
    }

    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is! Location) {
      return false;
    } else {
      return (other.x == x) && (other.y == y);
    }
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => id;
}
