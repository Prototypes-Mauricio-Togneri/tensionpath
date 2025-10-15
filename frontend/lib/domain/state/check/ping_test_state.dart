import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_health_check.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/utils/connection.dart';
import 'package:tensionpath/utils/error_handler.dart';
import 'package:tensionpath/utils/navigation.dart';

class PingStateState extends BaseState {
  late final Connection connection;
  DateTime start = DateTime.now();
  bool isRunning = false;
  int lastPing = 0;
  int sum = 0;
  int count = 0;
  String result = '';

  @override
  Future onLoad() async {
    connection = Connection(
      host: Environment.get.serverHost,
      onMessage: _onMessage,
      onDisconnected: _onDisconnected,
      onError: _onError,
    );
    await connection.connect();
  }

  @override
  void onDestroy() {
    onStop();
    connection.disconnect();
  }

  void _onMessage(dynamic json) {
    if (json is JsonHealthCheck) {
      receivePing();
    }
  }

  void _onDisconnected() {}

  void _onError(dynamic error) => ErrorHandler.process(error);

  void onClose() => Navigation.pop();

  void sendPing() {
    if (isRunning) {
      start = DateTime.now();
      connection.send(JsonMessage.check(''));
    }
  }

  Future receivePing() async {
    final DateTime end = DateTime.now();
    lastPing = end.difference(start).inMilliseconds;
    sum += lastPing;
    count++;
    result = 'Last ping: ${lastPing}ms\nAvg. ping: ${sum ~/ count}ms';
    notify();

    await Future.delayed(const Duration(seconds: 1));
    sendPing();
  }

  void onStart() {
    lastPing = 0;
    sum = 0;
    count = 0;
    isRunning = true;
    notify();
    sendPing();
  }

  void onStop() {
    isRunning = false;
    notify();
  }
}
