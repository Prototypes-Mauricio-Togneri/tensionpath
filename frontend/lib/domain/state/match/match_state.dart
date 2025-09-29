import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/update.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_start.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_update.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_welcome.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/presentation/common/dialogs/confirmation_dialog.dart';
import 'package:tensionpath/presentation/common/dialogs/info_dialog.dart';
import 'package:tensionpath/utils/connection.dart';
import 'package:tensionpath/utils/error_handler.dart';
import 'package:tensionpath/utils/navigation.dart';

class MatchState extends BaseState {
  final String host;
  final String matchId;
  final String selfId;
  late final Connection connection;
  MatchStatus matchStatus = MatchStatus.playing;
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
    if (matchStatus == MatchStatus.playing) {
      if (json is JsonWelcome) {
        _onWelcome();
      } else if (json is JsonStart) {
        _onStart(Match.fromJson(json.match));
      } else if (json is JsonUpdate) {
        _onUpdate(MatchUpdate.fromJson(json.match));
      }
    }
  }

  void _onWelcome() => connection.send(
    JsonMessage.join(
      matchId: matchId,
      playerId: selfId,
    ),
  );

  void _onStart(Match match) {
    gameComponent = GameComponent(
      match: match,
      matchState: this,
    );
    Delayed.post(notify);
  }

  void _onUpdate(MatchUpdate update) {
    MatchComponentRef.instance.onMatchUpdated(update);

    matchStatus = update.status;
    final String? winnerId = update.winner;

    if (winnerId != null) {
      onMatchFinished(winnerId == selfId);
    }
  }

  void _onDisconnected() {
    if (matchStatus == MatchStatus.playing) {
      InfoDialog.error(
        text: 'Server disconnection',
        onAccept: Navigation.pop,
      );
    }
  }

  void _onError(dynamic error) => ErrorHandler.process(error);

  void onDeployUnit({
    required Location location,
    required UnitType type,
  }) => connection.send(
    JsonMessage.deployUnit(
      matchId: matchId,
      location: location.toJson(),
      type: type,
    ),
  );

  void onUnitAction({
    required String unitId,
    required Location? targetLocation,
    required String? targetUnitId,
  }) => connection.send(
    JsonMessage.unitAction(
      matchId: matchId,
      unitId: unitId,
      targetLocation: targetLocation?.toJson(),
      targetUnitId: targetUnitId,
    ),
  );

  void onMatchFinished(bool hasWon) {
    if (hasWon) {
      InfoDialog.won(Navigation.pop);
    } else {
      InfoDialog.lost(Navigation.pop);
    }
  }

  void onOpenMenu() => ConfirmationDialog.quitMatch(_onSurrender);

  void _onSurrender() {
    connection.send(JsonMessage.surrenderMatch(matchId: matchId));
  }
}
