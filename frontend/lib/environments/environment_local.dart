import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tensionbase/environments/environment.dart';

class LocalEnvironment extends Environment {
  @override
  String get name => 'local';

  @override
  Future configure() async {
    FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);

    FirebaseFirestore.instance.settings = const Settings(
      host: '10.0.2.2:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );

    FirebaseFirestore.instance.useFirestoreEmulator('10.0.2.2', 8080);

    await FirebaseStorage.instance.useStorageEmulator('10.0.2.2', 9199);
  }
}
