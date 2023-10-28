import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameState extends BaseState {
  @override
  void onLoad() {
    final Uri wsUrl = Uri.parse(Environment.get.matchServerUrl);
    final WebSocketChannel channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((message) {
      print(message);
      channel.sink.add('Received: $message');
    });
  }
}
