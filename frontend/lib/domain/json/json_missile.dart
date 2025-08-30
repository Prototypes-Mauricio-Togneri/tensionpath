import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/json_position.dart';

part 'json_missile.g.dart';

@JsonSerializable()
class JsonMissile {
  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'currentCharge')
  final double currentCharge;

  @JsonKey(name: 'maxCharge')
  final double maxCharge;

  @JsonKey(name: 'bufferCharge')
  final double bufferCharge;

  @JsonKey(name: 'platforms')
  final Map<String, List<JsonPosition>> platforms;

  const JsonMissile({
    required this.position,
    required this.currentCharge,
    required this.maxCharge,
    required this.bufferCharge,
    required this.platforms,
  });

  factory JsonMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileToJson(this);
}
