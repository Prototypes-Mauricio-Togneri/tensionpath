// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_room_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRoomPlayer _$JsonRoomPlayerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonRoomPlayer', json, ($checkedConvert) {
      final val = JsonRoomPlayer(
        playerId: $checkedConvert('playerId', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonRoomPlayerToJson(JsonRoomPlayer instance) =>
    <String, dynamic>{'playerId': instance.playerId, 'name': instance.name};
