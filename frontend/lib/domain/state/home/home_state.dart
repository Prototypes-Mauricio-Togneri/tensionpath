import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/persistence/storage/deck_storage.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class HomeState extends BaseState {
  static const int MAX_CARDS = 6;

  final List<UnitType> deck = [];

  @override
  void onLoad() {
    loadDeck();
  }

  bool get isDeckFull => deck.length == MAX_CARDS;

  Future loadDeck() async {
    final List<UnitType> list = await DeckStorage.load();
    deck.clear();
    deck.addAll(list);
    notify();
  }

  void onPlay() => Navigation.lobbyScreen(deck);

  Future onUnits() async {
    await Navigation.unitsScreen();
    await loadDeck();
  }

  void onSettings() => Navigation.settingsScreen();

  Future onFullscreen() async {
    SetFullscreen.set();
    await Future.delayed(const Duration(seconds: 1));
    Navigation.homeScreen();
  }

  void onChangelog() => Navigation.changelogScreen();

  void onPingTest() => Navigation.pingTestScreen();
}
