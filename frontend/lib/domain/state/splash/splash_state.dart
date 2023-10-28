import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tensionpath/persistence/callables/matchmaking_callable.dart';

class SplashState extends BaseState {
  @override
  Future onLoad() async {
    StreamSubscription? subscription;
    subscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      subscription?.cancel();
      _processUser(user);
    });
  }

  Future _processUser(User? user) async {
    final User signedUser = await _getSignedUser(user);
    print(signedUser);
  }

  Future<User> _getSignedUser(User? user) async =>
      user ?? (await FirebaseAuth.instance.signInAnonymously()).user!;

  Future onMatchmaking() async {
    final result = await const MatchmakingCallable()(
      numberOfPlayers: 2,
    );
    print(result);
  }
}
