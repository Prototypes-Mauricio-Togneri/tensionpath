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

  @JsonKey(name: 'playerIndex')
  final String? playerIndex;

  @JsonKey(name: 'damage')
  final num? damage;

  const JsonEventMissile({
    required this.charge,
    required this.owner,
    required this.platforms,
    required this.fired,
    required this.playerIndex,
    required this.damage,
  });

  factory JsonEventMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonEventMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventMissileToJson(this);
}
