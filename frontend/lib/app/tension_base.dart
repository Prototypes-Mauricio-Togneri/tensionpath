import 'package:flutter/material.dart';
import 'package:tensionbase/presentation/splash/splash_screen.dart';
import 'package:tensionbase/utils/navigation.dart';
import 'package:tensionbase/utils/palette.dart';

class TensionBase extends StatelessWidget {
  const TensionBase();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tension Base',
      debugShowCheckedModeBanner: false,
      navigatorKey: Navigation.get.routes.key,
      theme: ThemeData(
        primaryColor: Palette.primary,
        primarySwatch: Palette.primary,
        scaffoldBackgroundColor: Palette.white,
      ),
      home: SplashScreen.instance(),
    );
  }
}
