import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_player.g.dart';

@JsonSerializable()
class JsonPlayer {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'deck')
  final List<UnitType> deck;

  const JsonPlayer({
    required this.name,
    required this.deck,
  });

  factory JsonPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerToJson(this);
}
