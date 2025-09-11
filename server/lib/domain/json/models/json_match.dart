import 'dart:convert';
import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'json_battlefield.dart';
import 'json_player.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'players')
  final List<JsonPlayer> players;

  @JsonKey(name: 'battlefield')
  final JsonBattlefield battlefield;

  JsonMatch({
    required this.createdAt,
    required this.players,
    required this.battlefield,
  });

  JsonMatch forPlayer({
    required String playerId,
    required String playerName,
  }) {
    for (final JsonPlayer player in players) {
      if (player.id == playerId) {
        player.name = playerName;
      }
    }

    return this;
  }

  static Future<JsonMatch> fromFile(String path) async {
    final File file = File(path);
    final String contents = await file.readAsString();
    final dynamic json = jsonDecode(contents) as Map<String, dynamic>;

    return JsonMatch.fromJson(json);
  }

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
