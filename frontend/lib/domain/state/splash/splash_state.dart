import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  @override
  void onLoad() {
    /*Authentication.checkIfAuthenticated(
      onSuccess: _onSuccess,
      onError: _onError,
    );*/
    Navigation.homeScreen();
  }

  /*void _onSuccess(User user) {
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
  }*/
}
