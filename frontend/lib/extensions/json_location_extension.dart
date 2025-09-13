import 'package:flame/game.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

extension JsonLocationExtension on JsonLocation {
  Vector2 toVector2() => Vector2(
    x.toDouble(),
    y.toDouble(),
  );
}
