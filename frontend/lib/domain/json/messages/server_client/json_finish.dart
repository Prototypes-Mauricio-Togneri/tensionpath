import 'package:json_annotation/json_annotation.dart';

part 'json_finish.g.dart';

@JsonSerializable()
class JsonFinish {
  @JsonKey(name: 'winner')
  final String winner;

  const JsonFinish({
    required this.winner,
  });

  factory JsonFinish.fromJson(Map<String, dynamic> json) =>
      _$JsonFinishFromJson(json);

  Map<String, dynamic> toJson() => _$JsonFinishToJson(this);
}
