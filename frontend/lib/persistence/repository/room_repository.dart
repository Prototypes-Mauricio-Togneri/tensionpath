class RoomRepository {
  /*static DocumentReference _ref([String? roomId]) =>
      FirebaseFirestore.instance.collection('rooms').doc(roomId);

  static Future<Room> create(JsonRoom json) async {
    final String roomId = Id.roomId(4);
    final DocumentReference ref = _ref(roomId);
    final JsonRoom finalJson = json.clone(id: ref.id);
    await ref.set(finalJson.toJson());

    return finalJson.object;
  }

  static StreamSubscription listen({
    required String roomId,
    required Function(Room) onUpdated,
  }) => _ref(roomId).snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final JsonRoom json = JsonRoom.fromJson(snapshot.json);
      onUpdated(json.object);
    }
  }, onError: ErrorHandler.process);

  static Future<Room> load(String roomId) async {
    final DocumentSnapshot snapshot = await _ref(roomId).get();

    if (snapshot.exists) {
      final JsonRoom json = JsonRoom.fromJson(snapshot.json);
      return json.object;
    } else {
      throw Exception('Room with ID $roomId not found');
    }
  }

  static Future<Room> update(JsonRoom json) async {
    await _ref(json.id).update(json.toJson());

    return json.object;
  }*/
}
