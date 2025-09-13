import 'package:json_annotation/json_annotation.dart';

part 'json_missile.g.dart';

@JsonSerializable()
class JsonMissile {
  @JsonKey(name: 'chargeMax')
  final double chargeMax;

  @JsonKey(name: 'chargeBuffer')
  final double chargeBuffer;

  const JsonMissile({
    required this.chargeMax,
    required this.chargeBuffer,
  });

  factory JsonMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileToJson(this);
}
