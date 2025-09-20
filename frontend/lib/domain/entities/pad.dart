import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_pad_start.dart';

class Pad {
  final Location location;
  final Position position;

  const Pad({
    required this.location,
    required this.position,
  });

  factory Pad.fromJson(JsonPadStart json) => Pad(
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
  );
}
