import 'dart:io';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/server/environment.dart';

class Logger {
  static late final Environment environment;

  static void initialize(Environment environment) {
    Logger.environment = environment;
  }

  static void log(WebSocket socket, String text) {
    print('[${socket.id} ${DateTime.now()}] $text');
  }

  static void info(String text) {
    print('[${DateTime.now()}] $text');
  }

  static void debug(String text) {
    if (environment.isDebug) {
      print('[${DateTime.now()}] $text');
    }
  }

  static void error(WebSocket socket, Object error) {
    print('[${socket.id} ${DateTime.now()}] Error: $error');
  }
}
