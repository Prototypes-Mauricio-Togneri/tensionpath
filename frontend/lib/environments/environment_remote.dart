import 'package:tensionpath/environments/environment.dart';

class RemoteEnvironment extends Environment {
  @override
  String get name => 'remote';

  @override
  String get serverHost => 'wss://tension-path-f3e538a71dcb.herokuapp.com';
}
