import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/model/room.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MatchState extends BaseState {
  final Room room;

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
  }

  void _onMessageReceived(dynamic message) {
    print(message);
    // channel.sink.add('Received: $message');
  }

  void _onDisconnected() {
    print('Disconnected');
  }

  void _onError(dynamic error) {
    print(error);
  }
}
