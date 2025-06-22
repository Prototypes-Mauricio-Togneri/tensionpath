import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/actions.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/action_type.dart';

class ActionMoveUnit extends Action {
  final Location origin;
  final Location target;

  const ActionMoveUnit({
    required super.playerId,
    required this.origin,
    required this.target,
  }) : super(type: ActionType.move);

  @override
  int get cost => origin.distance(target) * Constants.COST_MOVE_UNIT;

  static bool isValid({
    required Player self,
    required Battlefield battlefield,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) =>
      _isValidMovement(
        player: self,
        origin: nodeOrigin.location,
        target: nodeTarget.location,
      ) &&
      _isValidPath(
        self: self,
        battlefield: battlefield,
        nodeOrigin: nodeOrigin,
        nodeTarget: nodeTarget,
      );

  static bool _isValidMovement({
    required Player player,
    required Location origin,
    required Location target,
  }) {
    if (origin.x == target.x) {
      // Move vertically
      if (player.isPlayer1) {
        return origin.y > target.y;
      } else {
        return origin.y < target.y;
      }
    } else if (origin.y == target.y) {
      // Move diagonally
      if (player.isPlayer1) {
        return origin.x > target.x;
      } else {
        return origin.x < target.x;
      }
    } else if (origin.x - target.x == target.y - origin.y) {
      // Move diagonally
      if (player.isPlayer1) {
        return origin.y > target.y;
      } else {
        return origin.y < target.y;
      }
    }

    return false;
  }

  static bool _isValidPath({
    required Player self,
    required Battlefield battlefield,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) {
    final List<Location> locations = _pathNodes(
      player: self,
      origin: nodeOrigin.location,
      target: nodeTarget.location,
    );

    return _canPassThroughNodes(
          battlefield: battlefield,
          locations: locations,
        ) &&
        _doesNotCollideWithOtherActions(
          self: self,
          locations: locations,
          actions: self.actions,
        );
  }

  static List<Location> _pathNodes({
    required Player player,
    required Location origin,
    required Location target,
  }) {
    final List<Location> result = [];

    if (origin.x == target.x) {
      // Move vertically
      if (player.isPlayer1) {
        for (int i = 1; i <= (origin.y - target.y); i++) {
          result.add(Location(x: origin.x, y: origin.y - i));
        }
      } else {
        for (int i = 1; i <= (target.y - origin.y); i++) {
          result.add(Location(x: origin.x, y: origin.y + i));
        }
      }
    } else if (origin.y == target.y) {
      // Move diagonally
      if (player.isPlayer1) {
        for (int i = 1; i <= (origin.x - target.x); i++) {
          result.add(Location(x: origin.x - i, y: origin.y));
        }
      } else {
        for (int i = 1; i <= (target.x - origin.x); i++) {
          result.add(Location(x: origin.x + i, y: origin.y));
        }
      }
    } else if (origin.x - target.x == target.y - origin.y) {
      // Move diagonally
      if (player.isPlayer1) {
        for (int i = 1; i <= (origin.y - target.y); i++) {
          result.add(Location(x: origin.x + i, y: origin.y - i));
        }
      } else {
        for (int i = 1; i <= (target.y - origin.y); i++) {
          result.add(Location(x: origin.x - i, y: origin.y + i));
        }
      }
    }

    return result;
  }

  static bool _canPassThroughNodes({
    required Battlefield battlefield,
    required List<Location> locations,
  }) {
    for (int i = 0; i < locations.length; i++) {
      final Location location = locations[i];
      final Node node = battlefield.nodeById(location.id);
      final bool lastNode = i == locations.length - 1;

      final bool invalidStructure =
          node.structure != null && !node.structure!.type.canMoveUnit;
      final bool nodeHasUnit = !lastNode && node.hasUnit;
      final bool isNotRevealed = !lastNode && !node.isRevealed;

      if (invalidStructure || nodeHasUnit || isNotRevealed) {
        return false;
      }
    }

    return true;
  }

  static bool _doesNotCollideWithOtherActions({
    required Player self,
    required List<Location> locations,
    required Actions actions,
  }) {
    final List<ActionMoveUnit> moveActions = actions.moveActions;

    for (final Location location in locations) {
      final bool containLocation = moveActions.any(
        (action) => _actionContainLocation(
          self: self,
          location: location,
          action: action,
        ),
      );

      if (containLocation) {
        return false;
      }
    }

    return true;
  }

  static bool _actionContainLocation({
    required Player self,
    required Location location,
    required ActionMoveUnit action,
  }) {
    final List<Location> locations = _pathNodes(
      player: self,
      origin: action.origin,
      target: action.target,
    );

    return locations.any((loc) => loc == location);
  }
}
