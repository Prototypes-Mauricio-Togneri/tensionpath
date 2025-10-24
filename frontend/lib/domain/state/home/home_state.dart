import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/persistence/storage/deck_storage.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class HomeState extends BaseState {
  static const int MAX_CARDS = 6;

  final List<UnitType> deck = [];

  @override
  Future onLoad() async {
    deck.addAll(await DeckStorage.load());
    notify();
  }

  bool get isDeckFull => deck.length == MAX_CARDS;

  void onSettings() => Navigation.settingsScreen();

  void onChangelog() => Navigation.changelogScreen();

  void onPingTest() => Navigation.pingTestScreen();

  void onPlay() {
    DeckStorage.save(deck);
    Navigation.lobbyScreen(deck);
  }

  Future onFullscreen() async {
    SetFullscreen.set();
    await Future.delayed(const Duration(seconds: 1));
    Navigation.homeScreen();
  }
}
