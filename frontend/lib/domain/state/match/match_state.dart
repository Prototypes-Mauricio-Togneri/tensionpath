import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/json/json_message.dart';
import 'package:tensionpath/domain/json/json_welcome.dart';
import 'package:tensionpath/domain/model/room.dart';
import 'package:tensionpath/domain/model/user_logged.dart';
import 'package:tensionpath/utils/connection.dart';

class MatchState extends BaseState {
  final Room room;
  final List<String> events = ['Connecting'];
  late final Connection connection;

  MatchState(this.room) {
    connection = Connection(
      onMessage: _onMessage,
      onDisconnected: _onDisconnected,
      onError: _onError,
    );
  }

  @override
  void onLoad() {
    connection.connect();
    events.add('Connected');
    notify();
  }

  void _onMessage(dynamic json) {
    events.add('Received: $json');

    if (json is JsonWelcome) {
      connection.send(JsonMessage.joinRoom(
        roomId: room.id,
        playerId: LoggedUser.get.id,
      ));
    }
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
