import 'package:json_annotation/json_annotation.dart';

part 'json_event_unit_destroyed.g.dart';

@JsonSerializable()
class JsonEventUnitDestroyed {
  @JsonKey(name: 'id')
  final String id;

  const JsonEventUnitDestroyed({
    required this.id,
  });

  factory JsonEventUnitDestroyed.fromJson(Map<String, dynamic> json) =>
      _$JsonEventUnitDestroyedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventUnitDestroyedToJson(this);
}
