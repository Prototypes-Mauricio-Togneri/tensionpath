import 'package:json_annotation/json_annotation.dart';

part 'json_position.g.dart';

@JsonSerializable()
class JsonPosition {
  @JsonKey(name: 'x')
  final int x;

  @JsonKey(name: 'y')
  final int y;

  const JsonPosition({
    required this.x,
    required this.y,
  });

  factory JsonPosition.fromJson(Map<String, dynamic> json) =>
      _$JsonPositionFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPositionToJson(this);
}
