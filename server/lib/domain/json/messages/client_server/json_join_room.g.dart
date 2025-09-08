// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_join_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonJoinRoom _$JsonJoinRoomFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonJoinRoom', json, ($checkedConvert) {
      final val = JsonJoinRoom(
        roomId: $checkedConvert('roomId', (v) => v as String),
        playerId: $checkedConvert('playerId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonJoinRoomToJson(JsonJoinRoom instance) =>
    <String, dynamic>{'roomId': instance.roomId, 'playerId': instance.playerId};
