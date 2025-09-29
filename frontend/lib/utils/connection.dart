import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Connection {
  final String host;
  late final WebSocketChannel channel;
  final Function(dynamic) onMessage;
  final Function() onDisconnected;
  final Function(dynamic) onError;

  Connection({
    required this.host,
    required this.onMessage,
    required this.onDisconnected,
    required this.onError,
  });

  Future connect() async {
    channel = WebSocketChannel.connect(Uri.parse(host));
    await channel.ready;
    channel.stream.listen(
      _onMessageReceived,
      onDone: onDisconnected,
      onError: onError,
    );
  }

  void send(JsonMessage message) {
    channel.sink.add(message.toString());
  }

  void _onMessageReceived(dynamic message) {
    final dynamic data = jsonDecode(message);
    final JsonMessage json = JsonMessage.fromJson(data);
    onMessage(json.message);
  }

  void disconnect() {
    channel.sink.close(WebSocketStatus.normalClosure);
  }
}
