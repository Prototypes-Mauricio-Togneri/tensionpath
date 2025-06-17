import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/utils/authentication.dart';
import 'package:tensionpath/utils/navigation.dart';

class HistoryState extends BaseState {
  List<Match>? _pastMatches;

  @override
  Future onLoad() async {
    _pastMatches = await MatchRepository.pastMatches(Authentication.userId);
    notify();
  }

  bool get isLoading => _pastMatches == null;

  List<Match> get pastMatches => _pastMatches ?? [];

  void onClose() => Navigation.pop();
}
