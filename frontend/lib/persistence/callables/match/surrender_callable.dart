import 'package:tensionpath/persistence/callables/callable.dart';

class SurrenderCallable extends Callable {
  const SurrenderCallable() : super('surrenderCallable');

  Future call({required String matchId}) async {
    final Map<String, Object?> parameters = {'matchId': matchId};

    return super.invoke(parameters);
  }
}
