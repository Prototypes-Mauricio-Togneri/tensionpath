import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_start.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_welcome.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/presentation/common/dialogs/info_dialog.dart';
import 'package:tensionpath/utils/connection.dart';
import 'package:tensionpath/utils/navigation.dart';

class MatchState extends BaseState {
  final String host;
  final String matchId;
  final String selfId;
  late final Connection connection;
  MatchStatus matchStatus = MatchStatus.active;
  GameComponent? gameComponent;

  MatchState({
    required this.host,
    required this.matchId,
    required this.selfId,
  }) {
    connection = Connection(
      host: host,
      onMessage: _onMessage,
      onDisconnected: _onDisconnected,
      onError: _onError,
    );
  }

  bool get isLoading => gameComponent == null;

  @override
  Future onLoad() => connection.connect();

  @override
  void onDestroy() => connection.disconnect();

  void _onMessage(dynamic json) {
    if (matchStatus == MatchStatus.active) {
      if (json is JsonWelcome) {
        connection.send(
          JsonMessage.join(
            matchId: matchId,
            playerId: selfId,
          ),
        );
      } else if (json is JsonStart) {
        gameComponent = GameComponent(
          match: json.match,
          matchState: this,
        );
        Delayed.post(notify);
      }
    }

    /*if (match.selfWon) {
      GameComponentRef.instance.onMatchFinished(true);
    } else if (match.opponentWon) {
      GameComponentRef.instance.onMatchFinished(false);
    }*/
  }

  void _onDisconnected() => InfoDialog.error(
    text: 'Server disconnection',
    onAccept: Navigation.pop,
  );

  void _onError(dynamic error) {
    print(error);
  }

  void onDeployUnit({
    required JsonLocation location,
    required UnitType type,
  }) {
    connection.send(
      JsonMessage.deployUnit(
        matchId: matchId,
        location: location,
        type: type,
      ),
    );
  }
}
