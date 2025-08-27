import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_launcher.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_pad.dart';
import 'package:tensionpath/domain/json/json_position.dart';
import 'package:tensionpath/domain/json/json_resources.dart';

part 'json_node.g.dart';

@JsonSerializable()
class JsonNode {
  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'resources')
  final JsonResources? resources;

  @JsonKey(name: 'missile')
  final JsonMissile? missile;

  @JsonKey(name: 'pad')
  final JsonPad? pad;

  @JsonKey(name: 'launcher')
  final JsonLauncher? launcher;

  const JsonNode({
    required this.position,
    required this.resources,
    required this.missile,
    required this.pad,
    required this.launcher,
  });

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);
}
