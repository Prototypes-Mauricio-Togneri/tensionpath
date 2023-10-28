import 'package:tensionpath/environments/environment.dart';

class RemoteEnvironment extends Environment {
  @override
  String get name => 'remote';

  @override
  String get matchServerUrl => 'ws://zeronest.com:8888/ws';
}
