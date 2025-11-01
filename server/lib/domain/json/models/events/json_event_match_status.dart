import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/types/match_status.dart';

part 'json_event_match_status.g.dart';

@JsonSerializable()
class JsonEventMatchStatus {
  @JsonKey(name: 'status')
  final MatchStatus status;

  const JsonEventMatchStatus({
    required this.status,
  });

  factory JsonEventMatchStatus.fromJson(Map<String, dynamic> json) =>
      _$JsonEventMatchStatusFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventMatchStatusToJson(this);
}
