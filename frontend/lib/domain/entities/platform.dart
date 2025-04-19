import 'package:tensionpath/domain/entities/structures/structure_pad.dart';

class Platform {
  final String platformId;
  final List<StructurePad> pads;

  const Platform({required this.platformId, required this.pads});
}
