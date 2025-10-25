import 'package:json_annotation/json_annotation.dart';

part 'json_event_base_damaged.g.dart';

@JsonSerializable()
class JsonEventBaseDamaged {
  @JsonKey(name: 'playerIndex')
  final String playerIndex;

  @JsonKey(name: 'damage')
  final num damage;

  const JsonEventBaseDamaged({
    required this.playerIndex,
    required this.damage,
  });

  factory JsonEventBaseDamaged.fromJson(Map<String, dynamic> json) =>
      _$JsonEventBaseDamagedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventBaseDamagedToJson(this);
}
