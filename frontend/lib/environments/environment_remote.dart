import 'package:tensionpath/environments/environment.dart';

class RemoteEnvironment extends Environment {
  @override
  String get name => 'remote';

  @override
  String get serverHost => 'wss://zeronest.com/ws';
}
