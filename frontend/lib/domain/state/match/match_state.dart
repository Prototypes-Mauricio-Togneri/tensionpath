import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/entities/event.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_start.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_update.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_welcome.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/music.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
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
  Future onLoad() {
    Audio.get.playMusic(Music.MUSIC);

    return connection.connect();
  }

  @override
  void onDestroy() {
    Audio.get.stopMusic();
    Audio.get.stopAllSounds();
    connection.disconnect();
  }

  void _onMessage(dynamic json) {
    if (json is JsonWelcome) {
      _onWelcome();
    } else if (json is JsonStart) {
      _onStart(Match.fromJson(json.match));
    } else if (json is JsonUpdate) {
      _onUpdate(json.events.map(Event.fromJson).toList());
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

  void _onUpdate(List<Event> events) {
    MatchComponentRef.instance.onMatchUpdated(events);

    for (final Event event in events) {
      if (event is EventMatchFinished) {
        _onMatchFinished(winner: event.winner, loser: event.loser);
        break;
      }
    }
  }

  void _onDisconnected() {
    if (MatchComponentRef.instance.match.isPlaying) {
      InfoDialog.error(
        text: 'Server disconnection',
        onAccept: Navigation.pop,
      );
    }
  }

  void _onError(dynamic error) => ErrorHandler.process(error);

  void onUnlockBuilding(BuildingType buildingType) => connection.send(
    JsonMessage.unlockBuilding(
      matchId: matchId,
      type: buildingType,
    ),
  );

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

  void _onMatchFinished({
    required String? winner,
    required String? loser,
  }) {
    if ((winner != null) && (loser != null)) {
      if (winner == selfId) {
        Audio.get.playSound(Sound.EVA_MISSION_ACCOMPLISHED);
        InfoDialog.won(Navigation.pop);
      } else {
        Audio.get.playSound(Sound.EVA_MISSION_FAILED);
        InfoDialog.lost(Navigation.pop);
      }
    } else if ((winner == null) && (loser == null)) {
      InfoDialog.draw(Navigation.pop);
    }
  }

  void onOpenMenu() => ConfirmationDialog.quitMatch(_onSurrender);

  void _onSurrender() =>
      connection.send(JsonMessage.surrenderMatch(matchId: matchId));
}
