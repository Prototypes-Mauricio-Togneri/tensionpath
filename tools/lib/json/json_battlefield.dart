import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/json/json_lane.dart';

part 'json_battlefield.g.dart';

@JsonSerializable()
class JsonBattlefield {
  final List<JsonLane> lanes;

  const JsonBattlefield({
    required this.lanes,
  });

  factory JsonBattlefield.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBattlefieldToJson(this);
}
