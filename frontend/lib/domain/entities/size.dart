import 'package:tensionpath/domain/json/models/start/json_size.dart';

class Size {
  final num width;
  final num height;

  const Size({
    required this.width,
    required this.height,
  });

  factory Size.fromJson(JsonSize json) => Size(
    width: json.width,
    height: json.height,
  );
}
