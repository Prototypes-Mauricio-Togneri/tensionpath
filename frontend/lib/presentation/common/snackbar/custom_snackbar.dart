import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';

class CustomSnackbar {
  const CustomSnackbar._();

  static const Duration DURATION_SHORT = Duration(seconds: 1);

  static void show({required String text, required Duration duration}) {
    final BuildContext context = Navigation.context();
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    const double height = 100;
    final double margin = (size.width - width) / 2;

    final SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
        left: margin,
        right: margin,
        bottom: size.height - height,
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
