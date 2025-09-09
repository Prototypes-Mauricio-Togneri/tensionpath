import 'package:json_annotation/json_annotation.dart';

part 'json_error.g.dart';

@JsonSerializable()
class JsonError {
  @JsonKey(name: 'message')
  final String message;

  const JsonError({
    required this.message,
  });

  factory JsonError.fromJson(Map<String, dynamic> json) =>
      _$JsonErrorFromJson(json);

  Map<String, dynamic> toJson() => _$JsonErrorToJson(this);
}
