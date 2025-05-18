import 'dart:ui';
import 'package:tensionpath/domain/json/json_size.dart';

extension SizeExtension on Size {
  JsonSize toJsonSize() =>
      JsonSize(width: width.toInt(), height: height.toInt());
}
