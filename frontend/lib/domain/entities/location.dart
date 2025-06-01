import 'package:tensionpath/domain/entities/localizable.dart';

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

  bool isValidTarget(Localizable target) {
    return (x == target.getLocation.x) ||
        (y == target.getLocation.y) ||
        (x - target.getLocation.x == target.getLocation.y - y);
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
