import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/json_position.dart';

part 'json_missile.g.dart';

@JsonSerializable()
class JsonMissile {
  @JsonKey(name: 'position')
  JsonPosition position;

  @JsonKey(name: 'currentCharge')
  double currentCharge;

  @JsonKey(name: 'maxCharge')
  double maxCharge;

  @JsonKey(name: 'bufferCharge')
  double bufferCharge;

  @JsonKey(name: 'platforms')
  Map<String, List<JsonPosition>> platforms;

  JsonMissile({
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
