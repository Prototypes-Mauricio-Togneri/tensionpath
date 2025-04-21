import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/missile.dart';

part 'json_missile.g.dart';

@JsonSerializable()
class JsonMissile {
  @JsonKey(name: 'charge')
  final int charge;

  @JsonKey(name: 'maxCharge')
  final int maxCharge;

  @JsonKey(name: 'platforms')
  final int platforms;

  const JsonMissile({
    required this.charge,
    required this.maxCharge,
    required this.platforms,
  });

  Missile get object => Missile(
    charge: charge,
    maxCharge: maxCharge,
    numberOfPlatforms: platforms,
  );

  factory JsonMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileToJson(this);
}
