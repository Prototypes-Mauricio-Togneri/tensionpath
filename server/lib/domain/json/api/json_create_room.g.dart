// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_create_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonCreateRoom _$JsonCreateRoomFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonCreateRoom', json, ($checkedConvert) {
      final val = JsonCreateRoom(
        roomId: $checkedConvert('roomId', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        numberOfPlayers: $checkedConvert(
          'numberOfPlayers',
          (v) => (v as num).toInt(),
        ),
        matchType: $checkedConvert('matchType', (v) => v as String),
        players: $checkedConvert(
          'players',
          (v) => Map<String, String>.from(v as Map),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonCreateRoomToJson(JsonCreateRoom instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'createdAt': instance.createdAt.toIso8601String(),
      'numberOfPlayers': instance.numberOfPlayers,
      'matchType': instance.matchType,
      'players': instance.players,
    };
