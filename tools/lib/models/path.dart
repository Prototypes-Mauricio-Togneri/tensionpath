import 'package:tensionpath/generators/base_generator.dart';

class Path {
  final String name;
  final List<Vertex> vertices;

  const Path({
    required this.name,
    required this.vertices,
  });
}
