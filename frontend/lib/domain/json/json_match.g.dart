// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatch _$JsonMatchFromJson(Map<String, dynamic> json) => JsonMatch(
  id: json['id'] as String,
  version: (json['version'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  turn: (json['turn'] as num).toInt(),
  activePlayer: json['activePlayer'] as String,
  players:
      (json['players'] as List<dynamic>)
          .map((e) => JsonPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
);
