import 'package:json_annotation/json_annotation.dart';

part 'json_event_base_damage.g.dart';

@JsonSerializable()
class JsonEventBaseDamage {
  @JsonKey(name: 'playerIndex')
  final String playerIndex;

  @JsonKey(name: 'damage')
  final num damage;

  const JsonEventBaseDamage({
    required this.playerIndex,
    required this.damage,
  });

  factory JsonEventBaseDamage.fromJson(Map<String, dynamic> json) =>
      _$JsonEventBaseDamageFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventBaseDamageToJson(this);
}
