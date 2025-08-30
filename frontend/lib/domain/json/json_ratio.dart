import 'package:flame/components.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_ratio.g.dart';

@JsonSerializable()
class JsonRatio {
  @JsonKey(name: 'width')
  final double width;

  @JsonKey(name: 'height')
  final double height;

  const JsonRatio({required this.width, required this.height});

  Vector2 get object => Vector2(width, height);

  factory JsonRatio.fromJson(Map<String, dynamic> json) =>
      _$JsonRatioFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRatioToJson(this);
}
