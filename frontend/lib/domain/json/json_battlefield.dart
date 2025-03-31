import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_node.dart';

part 'json_battlefield.g.dart';

@JsonSerializable()
class JsonBattlefield {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'size')
  final JsonSize size;

  @JsonKey(name: 'gridRatio')
  final JsonRatio gridRatio;

  @JsonKey(name: 'nodes')
  final List<JsonNode> nodes;

  const JsonBattlefield({
    required this.id,
    required this.size,
    required this.gridRatio,
    required this.nodes,
  });

  factory JsonBattlefield.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldFromJson(json);
}

@JsonSerializable()
class JsonSize {
  @JsonKey(name: 'width')
  final int width;

  @JsonKey(name: 'height')
  final int height;

  const JsonSize({required this.width, required this.height});

  factory JsonSize.fromJson(Map<String, dynamic> json) =>
      _$JsonSizeFromJson(json);
}

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
