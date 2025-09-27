import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tensionpath/environments/environment.dart';

class LocalEnvironment extends Environment {
  @override
  String get name => 'local';

  @override
  bool get joinTestMatch =>
      const String.fromEnvironment(
        'JOIN_TEST_MATCH',
        defaultValue: 'false',
      ).toLowerCase() ==
      'true';

  @override
  Future configure() async {
    await FirebaseAuth.instance.useAuthEmulator(Environment.get.host, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(Environment.get.host, 8080);
  }
}
