import 'package:json_annotation/json_annotation.dart';

part 'json_event_unit_updated.g.dart';

@JsonSerializable()
class JsonEventUnitUpdated {
  @JsonKey(name: 'id')
  final String id;

  //   * health
  //   * locked node
  //   * move
  //   * unit target
  //   * base target
  //   * attack (target? damage?)

  const JsonEventUnitUpdated({
    required this.id,
  });

  factory JsonEventUnitUpdated.fromJson(Map<String, dynamic> json) =>
      _$JsonEventUnitUpdatedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventUnitUpdatedToJson(this);
}
