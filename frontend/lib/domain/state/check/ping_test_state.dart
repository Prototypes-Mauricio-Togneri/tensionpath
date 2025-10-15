import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/navigation.dart';

class PingStateState extends BaseState {
  bool isRunning = false;
  String result = '';

  void onClose() => Navigation.pop();

  void onStart() {
    isRunning = true;
    result = 'Running...';
    notify();
  }

  void onStop() {
    isRunning = false;
    notify();
  }
}
