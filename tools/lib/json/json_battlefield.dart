import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/json/json_path.dart';

part 'json_battlefield.g.dart';

@JsonSerializable()
class JsonBattlefield {
  final List<JsonPath> paths;

  const JsonBattlefield({
    required this.paths,
  });

  factory JsonBattlefield.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBattlefieldToJson(this);
}
