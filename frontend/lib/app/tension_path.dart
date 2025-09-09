import 'package:flutter/material.dart';
import 'package:tensionpath/presentation/splash/splash_screen.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';

class TensionPath extends StatelessWidget {
  const TensionPath();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tension Path',
      debugShowCheckedModeBanner: false,
      navigatorKey: Navigation.get.routes.key,
      theme: ThemeData(
        primaryColor: Palette.PRIMARY,
        primarySwatch: Palette.PRIMARY,
        colorScheme: ColorScheme.fromSeed(seedColor: Palette.PRIMARY),
        scaffoldBackgroundColor: Palette.GAME_BACKGROUND,
      ),
      home: SplashScreen.instance(),
    );
  }
}
