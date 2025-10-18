import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_created.dart';

part 'json_event.g.dart';

@JsonSerializable()
class JsonEvent {
  @JsonKey(name: 'unit_created')
  final JsonEventUnitCreated? unitCreated;

  const JsonEvent({
    required this.unitCreated,
  });

  factory JsonEvent.fromJson(Map<String, dynamic> json) =>
      _$JsonEventFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventToJson(this);
}
