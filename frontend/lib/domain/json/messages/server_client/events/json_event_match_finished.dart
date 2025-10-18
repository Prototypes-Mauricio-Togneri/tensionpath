import 'package:json_annotation/json_annotation.dart';

part 'json_event_match_finished.g.dart';

@JsonSerializable()
class JsonEventMatchFinished {
  @JsonKey(name: 'winner')
  final String? winner;

  @JsonKey(name: 'loser')
  final String? loser;

  const JsonEventMatchFinished({
    required this.winner,
    required this.loser,
  });

  factory JsonEventMatchFinished.fromJson(Map<String, dynamic> json) =>
      _$JsonEventMatchFinishedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventMatchFinishedToJson(this);
}
