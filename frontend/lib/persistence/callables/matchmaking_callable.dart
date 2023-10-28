import 'package:cloud_functions/cloud_functions.dart';
import 'package:tensionpath/persistence/callables/callable.dart';

class MatchmakingCallable extends Callable {
  const MatchmakingCallable() : super('matchmakingCallable');

  Future<HttpsCallableResult<T>> call<T>({
    required int numberOfPlayers,
  }) {
    final Map<String, Object?> parameters = {
      'numberOfPlayers': numberOfPlayers,
    };

    return super.invoke(parameters);
  }
}
