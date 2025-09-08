import 'dart:io';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/utils/constants.dart';

class Logger {
  static void log(WebSocket socket, String text) {
    if (Constants.LOGS_ENABLED) {
      print('[${socket.id} ${DateTime.now()}] $text');
    }
  }

  static void info(String text) {
    if (Constants.LOGS_ENABLED) {
      print('[${DateTime.now()}] $text');
    }
  }

  static void error(WebSocket socket, Object error) {
    if (Constants.LOGS_ENABLED) {
      print('[${socket.id} ${DateTime.now()}] Error: $error');
    }
  }
}
