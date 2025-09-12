import 'package:tensionpath/domain/engine/location.dart';

class Platform {
  final String id;
  final List<Location> pads;

  const Platform({required this.id, required this.pads});

  factory Platform.fromJson(json) => Platform(
    id: json.id,
    pads: json.pads.map((pad) => Location.fromJson(pad)).toList(),
  );
}
