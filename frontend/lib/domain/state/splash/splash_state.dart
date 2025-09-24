import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/persistence/storage/settings_storage.dart';
import 'package:tensionpath/utils/authentication.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  @override
  void onLoad() {
    if (Environment.get.joinTestMatch) {
      Navigation.matchScreen(
        host: 'ws://localhost:3000',
        matchId: 'test-match-id',
        userId: 'AAA',
      );
    } else {
      Authentication.checkIfAuthenticated(
        onSuccess: _onSuccess,
        onError: _onError,
      );
    }
  }

  void _onSuccess(User user) {
    _processUser(user);
  }

  Future _onError() async {
    final User user = await Authentication.signInAnonymously();
    await _processUser(user);
  }

  Future _processUser(User user) async {
    final String name = await SettingsStorage.loadName();

    if (name.isEmpty) {
      Navigation.setupScreen();
    } else {
      Navigation.homeScreen();
    }
  }
}
