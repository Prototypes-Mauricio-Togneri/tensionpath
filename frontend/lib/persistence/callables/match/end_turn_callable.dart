import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/persistence/callables/callable.dart';

class EndTurnCallable extends Callable {
  const EndTurnCallable() : super('endTurnCallable');

  Future call({
    required String matchId,
    required List<JsonAction> actions,
  }) async {
    final Map<String, Object?> parameters = {
      'matchId': matchId,
      'actions': actions,
    };

    return super.invoke(parameters);
  }
}
