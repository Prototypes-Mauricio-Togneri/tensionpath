class MapList<K, V> extends Iterable<V> {
  final Map<K, V> _map = {};
  final List<V> _list = [];

  void add(K key, V value) {
    _map[key] = value;
    _list.add(value);
  }

  V get(K key) => _map[key]!;

  bool has(K key) => _map.containsKey(key);

  void remove(K key, V value) {
    _map.remove(key);
    _list.remove(value);
  }

  @override
  Iterator<V> get iterator => _list.iterator;
}
