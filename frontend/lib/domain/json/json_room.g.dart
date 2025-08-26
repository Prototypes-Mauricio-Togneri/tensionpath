// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRoom _$JsonRoomFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonRoom', json, ($checkedConvert) {
      final val = JsonRoom(
        id: $checkedConvert('id', (v) => v as String),
        version: $checkedConvert('version', (v) => (v as num).toInt()),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        numberOfPlayers: $checkedConvert(
          'numberOfPlayers',
          (v) => (v as num).toInt(),
        ),
        visibility: $checkedConvert(
          'visibility',
          (v) => $enumDecode(_$RoomVisibilityEnumMap, v),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$RoomStatusEnumMap, v),
        ),
        playerIds: $checkedConvert(
          'playerIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        players: $checkedConvert(
          'players',
          (v) => Map<String, String>.from(v as Map),
        ),
        matchType: $checkedConvert('matchType', (v) => v as String),
        matchId: $checkedConvert('matchId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$JsonRoomToJson(JsonRoom instance) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  'createdAt': dateToJson(instance.createdAt),
  'numberOfPlayers': instance.numberOfPlayers,
  'visibility': _$RoomVisibilityEnumMap[instance.visibility]!,
  'status': _$RoomStatusEnumMap[instance.status]!,
  'playerIds': instance.playerIds,
  'players': instance.players,
  'matchType': instance.matchType,
  'matchId': ?instance.matchId,
};

const _$RoomVisibilityEnumMap = {
  RoomVisibility.public: 'public',
  RoomVisibility.private: 'private',
};

const _$RoomStatusEnumMap = {
  RoomStatus.open: 'open',
  RoomStatus.close: 'close',
};
