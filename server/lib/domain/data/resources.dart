import 'package:tensionpath/domain/entities/resource.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Resources {
  final IterableMap<String, Resource> _resources;

  const Resources(this._resources);

  Resource get(String id) => _resources.get(id);

  List<Resource> get list => _resources.list;
}
