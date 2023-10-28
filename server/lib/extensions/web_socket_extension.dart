import 'dart:io';

import 'package:tensionbase/json/json_message.dart';
import 'package:tensionbase/utils/logger.dart';

extension WebSocketExtension on WebSocket {
  void send(JsonMessage json) {
    add(json.toString());
    Logger.log(this, '>>> $json');
  }
}
