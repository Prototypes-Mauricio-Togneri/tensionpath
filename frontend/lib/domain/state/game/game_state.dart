import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';

class GameState {
  final Battlefield battlefield;
  int commandPointsSelected = 0;

  GameState({
    required this.battlefield,
  });

  void onCommandPointsSelected(int amount) {
    commandPointsSelected = amount;
  }

  void onNodeSelected(Node node) {
    print('Clicked node: ${node.id}');
  }

  void onLaneSelected(Lane lane) {
    print('Clicked lane: ${lane.id}');

    if (commandPointsSelected > 0) {
      _deployUnit(commandPointsSelected, lane);
    }
  }

  void _deployUnit(int cp, Lane lane) {
    
  }
}
