import 'package:tensionpath/domain/entities/node.dart';

class Platform {
  final String platformId;
  final List<Node> nodes;

  const Platform({required this.platformId, required this.nodes});
}
