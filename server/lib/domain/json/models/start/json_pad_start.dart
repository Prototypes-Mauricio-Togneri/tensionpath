import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

part 'json_pad_start.g.dart';

@JsonSerializable()
class JsonPadStart {
  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'position')
  final JsonPosition position;

  const JsonPadStart({
    required this.location,
    required this.position,
  });

  factory JsonPadStart.fromJson(Map<String, dynamic> json) =>
      _$JsonPadStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPadStartToJson(this);
}
