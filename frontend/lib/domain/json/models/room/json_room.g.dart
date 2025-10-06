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
        createdAt: $checkedConvert('createdAt', (v) => v as String),
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
        matchType: $checkedConvert('matchType', (v) => v as String),
        users: $checkedConvert(
          'users',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, JsonUser.fromJson(e as Map<String, dynamic>)),
          ),
        ),
        matchId: $checkedConvert('matchId', (v) => v as String?),
        matchHost: $checkedConvert('matchHost', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$JsonRoomToJson(JsonRoom instance) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  'createdAt': instance.createdAt,
  'numberOfPlayers': instance.numberOfPlayers,
  'visibility': _$RoomVisibilityEnumMap[instance.visibility]!,
  'status': _$RoomStatusEnumMap[instance.status]!,
  'matchType': instance.matchType,
  'users': instance.users.map((k, e) => MapEntry(k, e.toJson())),
  'matchId': ?instance.matchId,
  'matchHost': ?instance.matchHost,
};

const _$RoomVisibilityEnumMap = {
  RoomVisibility.public: 'public',
  RoomVisibility.private: 'private',
};

const _$RoomStatusEnumMap = {
  RoomStatus.open: 'open',
  RoomStatus.close: 'close',
};
