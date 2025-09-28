import 'package:tensionpath/domain/data/nodes.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_node_start.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Node {
  final String id;
  final NodeType type;
  final Location location;
  final Position position;
  Unit? lockedUnit;

  Node({
    required this.id,
    required this.type,
    required this.location,
    required this.position,
  });

  bool get isFree => lockedUnit == null;

  bool get isLocked => lockedUnit != null;

  bool notLockedBy(Unit unit) => (lockedUnit != null) && (lockedUnit != unit);

  void lock(Unit unit) {
    lockedUnit = unit;
  }

  void unlock() {
    lockedUnit = null;
  }

  static Nodes load(List<JsonNodeStart> nodes) {
    final IterableMap<String, Node> result = IterableMap();

    for (final JsonNodeStart jsonNode in nodes) {
      final Node node = Node(
        id: jsonNode.location.id,
        type: jsonNode.type,
        location: Location.fromJson(jsonNode.location),
        position: Position.fromJson(jsonNode.position),
      );
      result.add(node.id, node);
    }

    return Nodes(result);
  }

  JsonNodeStart toJsonStart() => JsonNodeStart(
    location: location.toJson(),
    position: position.toJson(),
    type: type,
  );

  @override
  bool operator ==(Object other) => other is Node && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
