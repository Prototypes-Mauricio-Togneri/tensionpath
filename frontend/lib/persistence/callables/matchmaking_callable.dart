import 'package:cloud_functions/cloud_functions.dart';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/model/document.dart';
import 'package:tensionpath/domain/model/room.dart';
import 'package:tensionpath/persistence/callables/callable.dart';

class MatchmakingCallable extends Callable {
  const MatchmakingCallable() : super('matchmakingCallable');

  Future<Room> call<T>({
    required int numberOfPlayers,
  }) async {
    final Map<String, Object?> parameters = {
      'numberOfPlayers': numberOfPlayers,
    };

    final HttpsCallableResult<dynamic> result = await super.invoke(parameters);

    final Document document = Document.fromJsonObject(Json.object(result.data));

    return Room.fromDocument(document);
  }
}
