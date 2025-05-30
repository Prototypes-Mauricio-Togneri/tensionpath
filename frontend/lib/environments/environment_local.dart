import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/environments/environment.dart';

class LocalEnvironment extends Environment {
  @override
  String get name => 'local';

  @override
  Future configure() async {
    FirebaseFirestore.instance.useFirestoreEmulator(Environment.get.host, 8080);
  }
}
