import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/utils/palette.dart';

part 'json_player.g.dart';

@JsonSerializable()
class JsonPlayer {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'isSelf')
  final bool isSelf;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'baseHealth')
  final int baseHealth;

  @JsonKey(name: 'baseMaxHealth')
  final int baseMaxHealth;

  @JsonKey(name: 'resources')
  final double resources;

  const JsonPlayer({
    required this.id,
    required this.isSelf,
    required this.name,
    required this.baseHealth,
    required this.baseMaxHealth,
    required this.resources,
  });

  bool get isOpponent => !isSelf;

  bool get isPlayer1 => id == Constants.PLAYER_1;

  bool get isPlayer2 => id == Constants.PLAYER_2;

  Color get color => isPlayer1 ? Palette.PLAYER_1 : Palette.PLAYER_2;

  factory JsonPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerToJson(this);
}
