import 'package:json_annotation/json_annotation.dart';

part 'json_event_missile.g.dart';

@JsonSerializable()
class JsonEventMissile {
  @JsonKey(name: 'charge')
  final num charge;

  @JsonKey(name: 'owner')
  final String? owner;

  @JsonKey(name: 'platforms')
  final Map<String, String?> platforms;

  @JsonKey(name: 'fired')
  final bool fired;

  const JsonEventMissile({
    required this.charge,
    required this.owner,
    required this.platforms,
    required this.fired,
  });

  factory JsonEventMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonEventMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventMissileToJson(this);
}
