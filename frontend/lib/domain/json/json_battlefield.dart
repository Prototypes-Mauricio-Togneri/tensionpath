import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_ratio.dart';
import 'package:tensionpath/domain/json/json_size.dart';

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

  Map<String, dynamic> toJson() => _$JsonBattlefieldToJson(this);
}
