import 'package:uuid/uuid.dart';

class Id {
  static String get get {
    final String uuid = const Uuid().v4();

    return uuid.replaceAll('-', '');
  }
}
