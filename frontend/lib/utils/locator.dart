import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/platform.dart';
import 'package:tensionpath/utils/set_url_strategy.dart';

final GetIt locator = GetIt.instance;

class Locator {
  static Future load() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBpGR88tMBiVA1Tvk48qQXqs1es7FaS2ac',
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
    }

    if (!Platform.isWeb) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    SetUrlStrategy.set();
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();

    locator.registerSingleton<Navigation>(Navigation());
  }
}
