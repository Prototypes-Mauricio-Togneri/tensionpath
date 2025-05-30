import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tensionpath/utils/authentication.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  @override
  void onLoad() {
    Authentication.checkIfAuthenticated(
      onSuccess: _onSuccess,
      onError: _onError,
    );
  }

  void _onSuccess(User user) {
    _processUser(user);
  }

  Future _onError() async {
    final User user = await Authentication.signInAnonymously();
    _processUser(user);
  }

  void _processUser(User user) => Navigation.homeScreen();
}
