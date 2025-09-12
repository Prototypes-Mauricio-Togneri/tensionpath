import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';

part 'json_update.g.dart';

@JsonSerializable()
class JsonUpdate {
  @JsonKey(name: 'match')
  final JsonMatchUpdate match;

  const JsonUpdate({
    required this.match,
  });

  factory JsonUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUpdateToJson(this);
}
