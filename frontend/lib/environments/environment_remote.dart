import 'package:tensionpath/environments/environment.dart';

class RemoteEnvironment extends Environment {
  @override
  String get name => 'remote';

  @override
  String get serverHost =>
      'ws://static.215.236.119.168.clients.your-server.de:8080';
}
