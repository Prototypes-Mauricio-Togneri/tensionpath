import 'dart:math';
import 'package:uuid/uuid.dart';

class Id {
  static String get get {
    final String uuid = const Uuid().v4();

    return uuid.replaceAll('-', '');
  }

  static String roomId(int length) {
    const String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final Random random = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => letters.codeUnitAt(random.nextInt(letters.length)),
      ),
    );
  }
}
