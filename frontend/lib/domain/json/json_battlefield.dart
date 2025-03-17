import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_size.dart';

part 'json_battlefield.g.dart';

@JsonSerializable()
class JsonBattlefield {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'width')
  final int width;

  @JsonKey(name: 'height')
  final int height;

  @JsonKey(name: 'nodeSize')
  final int nodeSize;

  @JsonKey(name: 'size')
  final JsonSize size;

  const JsonBattlefield({
    required this.id,
    required this.width,
    required this.height,
    required this.nodeSize,
    required this.size,
  });

  factory JsonBattlefield.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldFromJson(json);
}
