import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/game_component.dart';

extension ComponentExtension on Component {
  GameComponent get game => GameComponentRef.instance;
}
