import 'dart:async';
import 'dart:convert';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tensionpath/domain/json/json_version.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/utils/audio.dart';
import 'package:tensionpath/utils/authentication.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  bool newVersionAvailable = false;

  @override
  Future onLoad() async {
    await Audio.get.load();
    await _fetchLatestVersion();
  }

  Future _fetchLatestVersion() async {
    if (Environment.get.isRelease) {
      await _checkVersion();
    } else {
      _authenticate();
    }
  }

  Future _checkVersion() async {
    final Response response = await get(
      Uri.parse(
        'https://europe-west6-tension-path.cloudfunctions.net/api/version',
      ),
    );
    if (response.statusCode == 200) {
      final JsonVersion data = JsonVersion.fromJson(jsonDecode(response.body));
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      if ((data.buildNumber != packageInfo.buildNumber) ||
          (data.version != packageInfo.version)) {
        newVersionAvailable = true;
        notify();
      } else {
        _authenticate();
      }
    }
  }

  void _authenticate() => Authentication.checkIfAuthenticated(
    onSuccess: _onSuccess,
    onError: _onError,
  );

  void _onSuccess(User user) {
    _processUser(user);
  }

  Future _onError() async {
    final User user = await Authentication.signInAnonymously();
    _processUser(user);
  }

  void _processUser(User user) => Navigation.homeScreen();
}
