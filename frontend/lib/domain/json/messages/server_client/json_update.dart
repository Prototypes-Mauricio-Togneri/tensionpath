import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';

part 'json_update.g.dart';

@JsonSerializable()
class JsonUpdate {
  @JsonKey(name: 'events')
  final List<JsonEvent> events;

  const JsonUpdate({
    required this.events,
  });

  factory JsonUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUpdateToJson(this);
}
