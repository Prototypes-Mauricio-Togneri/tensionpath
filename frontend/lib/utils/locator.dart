import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/platform/operations/set_url_strategy.dart';
import 'package:tensionpath/utils/navigation.dart';

final GetIt locator = GetIt.instance;

class Locator {
  static Future load(Environment environment) async {
    WidgetsFlutterBinding.ensureInitialized();

    /*if (Platform.isWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          authDomain: 'tension-path.firebaseapp.com',
          projectId: 'tension-path',
          storageBucket: 'tension-path.appspot.com',
          messagingSenderId: '183502893220',
          appId: '1:183502893220:web:2b1cc8c9b1378b23ecb631',
          measurementId: 'G-XBSE04LEGT',
        ),
      );
    } else {
      await Firebase.initializeApp();

      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }*/

    SetUrlStrategy.set();
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();

    locator.registerSingleton<Environment>(environment);
    locator.registerSingleton<Navigation>(Navigation());

    await environment.configure();
  }
}
