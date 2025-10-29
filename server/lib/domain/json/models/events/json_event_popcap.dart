import 'package:json_annotation/json_annotation.dart';

part 'json_event_popcap.g.dart';

@JsonSerializable()
class JsonEventPopcap {
  @JsonKey(name: 'popcap')
  final int popcap;

  const JsonEventPopcap({
    required this.popcap,
  });

  factory JsonEventPopcap.fromJson(Map<String, dynamic> json) =>
      _$JsonEventPopcapFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventPopcapToJson(this);
}
