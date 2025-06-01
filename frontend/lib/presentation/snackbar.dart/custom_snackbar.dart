import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';

class CustomSnackbar {
  const CustomSnackbar._();

  static const Duration DURATION_SHORT = Duration(seconds: 1);

  static const Duration DURATION_MEDIUM = Duration(seconds: 3);

  static const Duration DURATION_LONG = Duration(seconds: 5);

  static void show({required String text, required Duration duration}) {
    final BuildContext context = Navigation.context();
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size size = mediaQuery.size;
    final double canvasWidth = size.height / 1.9;
    final double paddingWidth = ((size.width - canvasWidth) / 2) + 1;

    final SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(14),
      margin: EdgeInsets.only(left: paddingWidth, right: paddingWidth),
      content: Center(
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Palette.SNACK_BACKGROUND,
      duration: duration,
    );

    Delayed.post(() {
      try {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        // ignore
      }
    });
  }

  /*static void _closeSnackbar(BuildContext context) {
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } catch (e) {
      // ignore
    }
  }*/

  static void invalidMove() =>
      show(text: 'Invalid move', duration: DURATION_MEDIUM);

  static void movementDistanceTooBig() =>
      show(text: 'Max distance is 3', duration: DURATION_MEDIUM);
}
