import 'package:json_annotation/json_annotation.dart';

part 'json_coordinates.g.dart';

@JsonSerializable()
class JsonCoordinates {
  @JsonKey(name: 'x')
  final double x;

  @JsonKey(name: 'y')
  final double y;

  const JsonCoordinates({
    required this.x,
    required this.y,
  });

  String get id => '$x,$y';

  factory JsonCoordinates.fromJson(Map<String, dynamic> json) =>
      _$JsonCoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$JsonCoordinatesToJson(this);
}
