import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/node.dart';

class GameState {
  final Battlefield battlefield;

  const GameState({
    required this.battlefield,
  });

  void onNodeSelected(Node node) {
    print('Clicked: ${node.id}');
  }
}
