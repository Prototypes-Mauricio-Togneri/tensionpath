import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/persistence/callables/matchmaking_callable.dart';

class SplashState extends BaseState {
  Future onMatchmaking() async {
    final result = await const MatchmakingCallable()(
      numberOfPlayers: 2,
    );
    print(result);
  }
}
