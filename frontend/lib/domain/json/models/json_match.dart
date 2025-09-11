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

  JsonPlayer get self => players.firstWhere((player) => player.isSelf);

  JsonPlayer get opponent => players.firstWhere((player) => !player.isSelf);

  bool get selfWon => (self.baseHealth > 0) && (opponent.baseHealth <= 0);

  bool get opponentWon => (opponent.baseHealth > 0) && (self.baseHealth <= 0);

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
