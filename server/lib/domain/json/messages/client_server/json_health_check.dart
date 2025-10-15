import 'package:json_annotation/json_annotation.dart';

part 'json_health_check.g.dart';

@JsonSerializable()
class JsonHealthCheck {
  @JsonKey(name: 'id')
  final String id;

  const JsonHealthCheck({
    required this.id,
  });

  factory JsonHealthCheck.fromJson(Map<String, dynamic> json) =>
      _$JsonHealthCheckFromJson(json);

  Map<String, dynamic> toJson() => _$JsonHealthCheckToJson(this);
}
