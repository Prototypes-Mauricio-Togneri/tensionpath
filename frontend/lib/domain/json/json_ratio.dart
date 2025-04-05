import 'package:json_annotation/json_annotation.dart';

part 'json_ratio.g.dart';

@JsonSerializable()
class JsonRatio {
  @JsonKey(name: 'width')
  final double width;

  @JsonKey(name: 'height')
  final double height;

  const JsonRatio({required this.width, required this.height});

  factory JsonRatio.fromJson(Map<String, dynamic> json) =>
      _$JsonRatioFromJson(json);
}
