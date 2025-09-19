import 'dart:math';

import 'package:tensionpath/domain/entities/size.dart';

class Constants {
  static const bool LOGS_ENABLED = true;

  static const String PLAYER_1 = '1';
  static const String PLAYER_2 = '2';

  static Size NODE_SIZE = Size(
    width: 10 * (sqrt(3) / 2),
    height: 10,
  );
}
