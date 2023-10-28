import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tensionbase/environments/environment.dart';
import 'package:tensionbase/utils/navigation.dart';

final GetIt locator = GetIt.instance;

class Locator {
  static Future load(Environment environment) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCl1kOtB9I7NPhkFXAudv7BMh-pTmk6KmU',
          authDomain: 'tensionbase.firebaseapp.com',
          projectId: 'tensionbase',
          storageBucket: 'tensionbase.appspot.com',
          messagingSenderId: '1033661841987',
          appId: '1:1033661841987:web:576957ca64beab04754af6',
          measurementId: 'G-620KWRJ6Y1',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }

    //setUrlStrategy(EmptyUrlStrategy());

    locator.registerSingleton<Environment>(environment);
    locator.registerSingleton<Navigation>(Navigation());
  }
}
