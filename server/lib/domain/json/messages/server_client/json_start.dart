import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';

part 'json_start.g.dart';

@JsonSerializable()
class JsonStart {
  @JsonKey(name: 'match')
  final JsonMatchStart match;

  const JsonStart({
    required this.match,
  });

  factory JsonStart.fromJson(Map<String, dynamic> json) =>
      _$JsonStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonStartToJson(this);
}
