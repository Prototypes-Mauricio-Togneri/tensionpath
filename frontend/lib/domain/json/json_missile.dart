import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/missile.dart';

part 'json_missile.g.dart';

@JsonSerializable()
class JsonMissile {
  @JsonKey(name: 'charge')
  int charge;

  @JsonKey(name: 'maxCharge')
  int maxCharge;

  @JsonKey(name: 'bufferCharge')
  int bufferCharge;

  @JsonKey(name: 'numberOfPlatforms')
  int numberOfPlatforms;

  @JsonKey(name: 'platforms')
  Map<String, String?> platforms;

  @JsonKey(name: 'owner')
  String? owner;

  JsonMissile({
    required this.charge,
    required this.maxCharge,
    required this.bufferCharge,
    required this.numberOfPlatforms,
    required this.platforms,
    required this.owner,
  });

  Missile get object => Missile(
    charge: charge,
    maxCharge: maxCharge,
    bufferCharge: bufferCharge,
    numberOfPlatforms: numberOfPlatforms,
    platforms: platforms,
    owner: owner,
  );

  factory JsonMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileToJson(this);
}
