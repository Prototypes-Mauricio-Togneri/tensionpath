import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  bool userLoggedIn = false;

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
    userLoggedIn = true;
    notify();
  }

  Future<User> _getSignedUser(User? user) async {
    if (user != null) {
      return user;
    } else {
      final UserCredential credential =
          await FirebaseAuth.instance.signInAnonymously();

      return credential.user!;
    }
  }

  void onMatchmaking() => Navigation.lobbyScreen();
}
