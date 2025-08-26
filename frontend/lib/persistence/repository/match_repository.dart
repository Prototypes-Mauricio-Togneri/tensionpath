class MatchRepository {
  //static DocumentReference _ref([String? id]) =>
  //    FirebaseFirestore.instance.collection('matches').doc(id);

  /*static StreamSubscription listen({
    required String matchId,
    required String selfId,
    required Function(Match) onUpdated,
  }) => _ref(matchId).snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      final Match match = json.object(selfId);
      onUpdated(match);
    }
  }, onError: ErrorHandler.process);*/
}
