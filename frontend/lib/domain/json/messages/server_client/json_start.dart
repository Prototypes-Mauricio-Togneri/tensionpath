import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/json_match.dart';

part 'json_start.g.dart';

@JsonSerializable()
class JsonStart {
  @JsonKey(name: 'match')
  final JsonMatch match;

  const JsonStart({
    required this.match,
  });

  factory JsonStart.fromJson(Map<String, dynamic> json) =>
      _$JsonStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonStartToJson(this);
}
