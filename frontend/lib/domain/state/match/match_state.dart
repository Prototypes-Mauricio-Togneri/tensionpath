import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/json/json_message.dart';
import 'package:tensionpath/domain/json/json_welcome.dart';
import 'package:tensionpath/domain/model/room.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MatchState extends BaseState {
  final Room room;
  final List<String> events = ['Connecting'];

  MatchState(this.room);

  @override
  void onLoad() {
    final Uri uri = Uri.parse(Environment.get.matchServerUrl);
    final WebSocketChannel channel = WebSocketChannel.connect(uri);
    channel.stream.listen(
      _onMessageReceived,
      onDone: _onDisconnected,
      onError: _onError,
    );
    events.add('Connected');
    notify();
  }

  void _onHandleMessage(JsonMessage json) {
    if (json is JsonWelcome) {
      channel.sink.add('Received: $message');
    }
  }

  void _onMessageReceived(dynamic message) {
    events.add('Received: $message');

    final JsonMessage json = JsonMessage.fromString(message);
    _onHandleMessage(json.message);
  }

  void _onDisconnected() {
    events.add('Disconnected');
    notify();
  }

  void _onError(dynamic error) {
    events.add('Error $error');
    notify();
  }
}
