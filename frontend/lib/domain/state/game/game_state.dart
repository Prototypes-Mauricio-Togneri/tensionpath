import 'package:dafluta/dafluta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameState extends BaseState {
  @override
  void onLoad() {
    //final Uri wsUrl = Uri.parse('ws://10.0.2.2:3000/ws');
    final Uri wsUrl = Uri.parse('ws://104.248.80.232:3000/ws');
    final WebSocketChannel channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((message) {
      print(message);
      channel.sink.add('Received: $message');
    });
  }
}
