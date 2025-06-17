import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';

class CustomSnackbar {
  const CustomSnackbar._();

  static const Duration DURATION_SHORT = Duration(seconds: 1);

  static void show({required String text, required Duration duration}) {
    final BuildContext context = Navigation.context();
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size size = mediaQuery.size;
    final double width = size.height / Constants.CONTAINER_RATIO;
    final double height =
        size.height * (Constants.UI_CONTROLS_HEIGHT / Constants.UI_HEIGHT);
    final double margin = (size.width - width) / 2;

    final SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(left: margin, right: margin),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // No round corners
      ),
      content: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
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

  static void insufficientResources() =>
      show(text: 'Insufficient resources', duration: DURATION_SHORT);

  static void invalidTarget() =>
      show(text: 'Invalid target', duration: DURATION_SHORT);
}
