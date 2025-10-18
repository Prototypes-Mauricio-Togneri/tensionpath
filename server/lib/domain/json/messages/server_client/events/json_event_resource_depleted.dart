import 'package:json_annotation/json_annotation.dart';

part 'json_event_resource_depleted.g.dart';

@JsonSerializable()
class JsonEventResourceDepleted {
  @JsonKey(name: 'id')
  final String id;

  const JsonEventResourceDepleted({
    required this.id,
  });

  factory JsonEventResourceDepleted.fromJson(Map<String, dynamic> json) =>
      _$JsonEventResourceDepletedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventResourceDepletedToJson(this);
}
