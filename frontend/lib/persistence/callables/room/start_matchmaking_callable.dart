import 'package:cloud_functions/cloud_functions.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/persistence/callables/callable.dart';
import 'package:tensionpath/utils/json.dart';

class StartMatchmakingCallable extends Callable {
  const StartMatchmakingCallable() : super('startMatchmakingCallable');

  Future<Room> call({
    required String playerName,
    required int version,
    required String matchType,
    required int numberOfPlayers,
    required RoomVisibility visibility,
    required List<UnitType> deck,
  }) async {
    final Map<String, Object?> parameters = {
      'name': playerName,
      'version': version,
      'matchType': matchType,
      'numberOfPlayers': numberOfPlayers,
      'visibility': visibility.name,
      'deck': deck.map((unit) => unit.name).toList(),
    };

    final HttpsCallableResult<dynamic> result = await super.invoke(parameters);

    final JsonRoom jsonRoom = JsonRoom.fromJson(Json.object(result.data));

    return jsonRoom.object;
  }
}
