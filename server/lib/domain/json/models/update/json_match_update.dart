import 'package:json_annotation/json_annotation.dart';

part 'json_match_update.g.dart';

@JsonSerializable()
class JsonMatchUpdate {
  @JsonKey(name: 'id')
  final String id;

  JsonMatchUpdate({
    required this.id,
  });

  factory JsonMatchUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchUpdateToJson(this);
}
