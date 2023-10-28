import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tensionbase/app/tension_base.dart';
import 'package:tensionbase/environments/environment_local.dart';
import 'package:tensionbase/utils/error_handler.dart';
import 'package:tensionbase/utils/locator.dart';

void main() {
  runZonedGuarded(() async {
    await Locator.load(LocalEnvironment());
    runApp(const TensionBase());
  }, ErrorHandler.onUncaughtError);
}
